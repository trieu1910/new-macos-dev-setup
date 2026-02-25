# macOS Quick Start

## Goal

Install the full approved workstation profile on a new Mac in one command flow.

## Standard install

```bash
git clone https://github.com/rldyourmnd/better-macos.git
cd better-macos
./install-macos.sh --start-orbstack
```

## Alternative modes

```bash
./install-macos.sh --dry-run
```

```bash
./install-macos.sh --skip-health-check
```

```bash
./scripts/bootstrap/bootstrap.sh --os darwin
```

## What the installer does

1. Ensures Homebrew is installed and updated.
2. Installs tools by domain modules.
3. Configures Docker context to OrbStack.
4. Appends managed env block to `~/.zshrc`.
5. Prints a health check summary unless skipped.

## After first run

1. Restart terminal or run:

```bash
source ~/.zshrc
```

2. Verify stack:

```bash
zsh -ic 'node --version; python3 --version; bun --version; rustc --version; flutter doctor -v | rg "No issues found|\\[✗\\]"'
```

## Idempotency

- Re-running the installer is safe.
- Existing packages are skipped when already installed.
