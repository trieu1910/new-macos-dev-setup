# macOS Quick Start

## Goal

Install the full approved workstation profile on a new Mac in one command flow.

## Standard install

```bash
git clone https://github.com/rldyourmnd/new-macos-dev-setup.git
cd new-macos-dev-setup
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
./install-macos.sh --with-stats
```

```bash
./install-macos.sh --with-stats --configure-stats
```

```bash
./scripts/bootstrap/bootstrap.sh --os darwin
```

## Profile-oriented install recipes

- Core baseline (recommended):

```bash
./install-macos.sh
```

- Full desktop profile (OrbStack context + Stats profile):

```bash
./install-macos.sh --start-orbstack --with-stats --configure-stats
```

- Reconfigure runtime with explicit dry-run first:

```bash
./install-macos.sh --dry-run
```

- Fast no-validate run when doing package refresh first:

```bash
./install-macos.sh --skip-health-check
```

## What the installer does

1. Ensures Homebrew is installed and updated.
2. Installs tools by domain modules.
3. Configures Docker context to OrbStack.
4. Installs Kubernetes toolchain (kubectl, helm, kustomize, kind, minikube, k9s).
5. Installs terminal productivity stack (starship, atuin, git-delta).
6. Applies stable shell integrations and prompt/history config files (`~/.zshrc`, `~/.config/starship.toml`, `~/.config/atuin/config.toml`).
7. Prints a health check summary unless skipped.

## After first run

1. Restart terminal or run:

```bash
source ~/.zshrc
```

2. Verify stack:

```bash
zsh -ic 'node --version; python3 --version; bun --version; rustc --version; flutter doctor -v | rg "No issues found|\\[✗\\]"; kubectl version --client=true; helm version --short; kind version; minikube version'
zsh -ic 'starship --version; atuin --version; git config --global --get core.pager; [ -f ~/.config/starship.toml ] && echo "starship config ok"; [ -f ~/.config/atuin/config.toml ] && echo "atuin config ok"'
```

## Idempotency

- Re-running the installer is safe.
- Existing packages are skipped when already installed.
