# CLAUDE.md

## Basic rules

- Unless otherwise specified, always respond in 日本語.
- `siraken` is my username.
- When using current date/time, always reference accurate date/time using `date` command or similar methods.
- If you don't know something or if something is unclear, don't force yourself to proceed with the task and communicate that to me clearly.
- When working with projects, determine which package manager to use by checking lock files (package-lock.json, yarn.lock, pnpm-lock.yaml, etc.) and project configuration files first.
- When suggesting commit messages, check recent commit history and user configuration for prefixes that might be automatically added by Git hooks, conventional commit tools, or user-defined templates. Only add prefixes if no automatic configuration is detected to avoid duplication.
- When tests fail, implement proper solutions rather than quick fixes that merely make tests pass. If implementation approaches are unclear or multiple valid options exist, ask for guidance on the preferred approach.
- Always explain your reasoning when making technical decisions or recommendations.
- When providing code solutions, include relevant context and explain any trade-offs or considerations.
- Don't rush to provide superficial solutions
- Thoroughly confirm the existence of problems before addressing them
- Don't dismiss user questions or concerns
