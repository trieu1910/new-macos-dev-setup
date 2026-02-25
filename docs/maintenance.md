# Maintenance Guide

## Update workflow

```bash
cd /Users/rldyourmnd/projects/new-macos-dev-setup
git pull
./install-macos.sh --start-orbstack
```

This keeps the machine aligned with repository state.

## Homebrew hygiene

```bash
brew update
brew upgrade
brew cleanup
```

Use this before or after bootstrap runs when doing scheduled maintenance.

## Drift control

- Keep `python3` on `3.13` (bootstrap enforces this).
- Keep `node` on `24.x` (bootstrap re-links `node@24` as active).
- Keep AI CLIs installed by intended method:
  - Claude Code: official curl
  - OpenCode: official curl
  - Gemini CLI: Homebrew formula
  - Codex: Homebrew cask

## Managed shell block

Bootstrap writes a managed `~/.zshrc` block with marker:

```bash
export BETTER_MACOS_ENV_VERSION=1
```

If you want to regenerate it:

1. Remove that marker line and related managed exports from `~/.zshrc`.
2. Re-run installer.

## Update validation

Run:

```bash
zsh -ic 'python3 --version; node --version; bun --version; flutter doctor -v | rg "No issues found|\\[✗\\]"; claude --version; opencode --version; gemini --version; codex --version'
```
