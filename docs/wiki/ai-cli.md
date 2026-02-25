# AI CLI

## Module

- `scripts/bootstrap/modules/technologies/ai-cli.sh`
- Script function: `install_ai_cli_stack`

## Installation methods

- `claude` via `https://claude.ai/install.sh`
- `opencode` via `https://opencode.ai/install`
- `gemini` via Homebrew formula `gemini-cli`
- `codex` via Homebrew cask `codex`

## Runtime behavior

- Removes conflicting `gemini` cask if present and installs `gemini-cli`.
- Removes `codex` formula if present and prefers cask install.

## Verification

```bash
claude --version
opencode --version
gemini --version
codex --version
```

