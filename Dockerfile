# syntax=docker/dockerfile:1

# ── Build stage ─────────────────────────────────────────────────────────────
FROM node:20-alpine AS builder

WORKDIR /app

# Copy manifests first for better layer caching
COPY package*.json tsconfig.json ./

# Install all deps (including dev for tsc)
RUN npm ci

# Copy source and compile TypeScript → JavaScript
COPY src ./src
RUN npx tsc

# ── Runtime stage ───────────────────────────────────────────────────────────
FROM node:20-alpine

WORKDIR /app

# Install production deps only
COPY package*.json ./
RUN npm ci --omit=dev && npm cache clean --force

# Copy compiled output from builder
COPY --from=builder /app/dist ./dist

# Documentation files
COPY README.md LICENSE ./

# Run as non-root user for security
RUN addgroup -S mcp && adduser -S mcp -G mcp && chown -R mcp:mcp /app
USER mcp

# MCP servers communicate over stdio — no port to expose
ENTRYPOINT ["node", "dist/index.js"]
