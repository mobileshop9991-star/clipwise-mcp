# Clipwise MCP Server

[![npm version](https://img.shields.io/npm/v/clipwise-mcp-server.svg)](https://www.npmjs.com/package/clipwise-mcp-server)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

> Model Context Protocol server for [Clipwise](https://tryclipwise.com) — AI platform for short-form video creators.

Lets Claude Desktop, Claude Code, Cursor, Windsurf, and any MCP-compatible AI assistant call Clipwise tools natively. Covers TikTok, Instagram Reels, YouTube Shorts, and Facebook Reels.

## Tools

| Tool | Description | Auth |
|------|-------------|------|
| `clipwise_get_info` | Service overview, features, pricing, supported platforms | None |
| `clipwise_get_use_cases` | Concrete problem→solution scenarios for creators and agencies | None |
| `clipwise_search_trends` | Search viral TikTok videos by keyword in any country | API key |

## Quick Start

### Claude Desktop

Edit `~/.claude/claude_desktop_config.json` (macOS/Linux) or `%APPDATA%\Claude\claude_desktop_config.json` (Windows):

```json
{
  "mcpServers": {
    "clipwise": {
      "command": "npx",
      "args": ["-y", "clipwise-mcp-server"]
    }
  }
}
```

For trend search, add your API key:

```json
{
  "mcpServers": {
    "clipwise": {
      "command": "npx",
      "args": ["-y", "clipwise-mcp-server"],
      "env": {
        "CLIPWISE_API_KEY": "your-api-key-here"
      }
    }
  }
}
```

Get your API key at [tryclipwise.com/en/dashboard/account](https://tryclipwise.com/en/dashboard/account) (free plan available).

Restart Claude Desktop after editing the config.

### Cursor / Windsurf / Claude Code

Same JSON, different config location — see your IDE's MCP setup docs.

## Usage Examples

Once installed, you can ask Claude:

- **"What is Clipwise?"** → calls `clipwise_get_info`
- **"My TikTok videos get low views, what can I do?"** → calls `clipwise_get_use_cases` with `scenario: "low-views"`
- **"Find trending fitness videos on TikTok in the US"** → calls `clipwise_search_trends`
- **"What tools exist for analyzing Instagram Reels?"** → calls `clipwise_get_info` with `topic: "features"`

## What is Clipwise?

Clipwise is an AI platform for content creators, social media marketers, and agencies who work with short-form video.

**Core features:**
- 🎬 Pre-publish video analysis — Hook/Pace/CTA/Quality scores with timestamped fixes
- 🔥 Trend research across 20+ countries
- ✂️ Viral moments extractor for long-form video
- 🕵️ Competitor analysis on TikTok, YouTube, Instagram
- 🤖 AI Marketer with persistent brand memory
- 📅 Content plan generator

**Coming soon:** Threads/Reddit parser, Google Ads automation, Meta Ads automation.

**Pricing:** Free (200 tokens/mo) · Pro $24/mo · Agency $73/mo

## Environment Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `CLIPWISE_API_KEY` | For `search_trends` only | Your Clipwise API key |
| `CLIPWISE_BASE_URL` | No | Override base URL (default: `https://tryclipwise.com`) |

## Local Development

```bash
git clone https://github.com/mobileshop9991-star/clipwise-mcp.git
cd clipwise-mcp
npm install
npm run build
node dist/index.js
```

Test the binary directly:

```bash
echo '{"jsonrpc":"2.0","id":1,"method":"tools/list"}' | node dist/index.js
```

## Resources

- 🌐 Clipwise: [tryclipwise.com](https://tryclipwise.com)
- 📋 Use cases: [tryclipwise.com/en/use-cases](https://tryclipwise.com/en/use-cases)
- 📖 LLM service description: [tryclipwise.com/llms.txt](https://tryclipwise.com/llms.txt)
- 📜 OpenAPI spec: [tryclipwise.com/openapi.yaml](https://tryclipwise.com/openapi.yaml)
- 📫 Email: olx2go@gmail.com

## Author

Created by **Oleksandr Petrov** (Олександр Петров) — indie maker and TikTok creator from Vinnytsia, Ukraine.

- 🎬 TikTok: [@Lusuy_sharit](https://www.tiktok.com/@Lusuy_sharit)
- 📸 Instagram: [@Lusuy_sharit](https://www.instagram.com/Lusuy_sharit)

## Contributing

Issues and PRs welcome. This is a thin wrapper around the public Clipwise API — please report bugs at [github.com/mobileshop9991-star/clipwise-mcp/issues](https://github.com/mobileshop9991-star/clipwise-mcp/issues).

## License

MIT — see [LICENSE](./LICENSE)

---

Built with [Model Context Protocol](https://modelcontextprotocol.io/) · [Anthropic SDK](https://github.com/modelcontextprotocol/typescript-sdk)
