FROM node:20-alpine

WORKDIR /app

# Copy manifests first for better layer caching
COPY package*.json tsconfig.json ./

# Install all deps (including dev for tsc build)
RUN npm ci

# Copy source and build
COPY src ./src
RUN npm run build

# Drop dev deps for a smaller final image
RUN npm prune --omit=dev

# MCP servers communicate over stdio — no port to expose
ENTRYPOINT ["node", "dist/index.js"]
