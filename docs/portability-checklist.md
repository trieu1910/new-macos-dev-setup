# Portability Checklist

Use this checklist to reproduce the same workstation profile on another Mac with minimal manual effort.

## Pre-flight

- Confirm internet access.
- Confirm Xcode Command Line Tools:
  - `xcode-select --install`
- Confirm disk space is sufficient.
- Confirm GitHub access for repository clone.

## Install

```bash
git clone https://github.com/rldyourmnd/new-macos-dev-setup.git
cd new-macos-dev-setup
./install-macos.sh --start-orbstack
```

## Post-install checks

```bash
zsh -ic 'python3 --version; python3.14 --version; node --version; bun --version; rustc --version; uv --version; flutter doctor -v | rg "No issues found|\\[✗\\]"; claude --version; opencode --version; gemini --version; codex --version'
zsh -ic 'starship --version; atuin --version; delta --version; command -v cargo-add'
zsh -ic 'kubectl version --client=true; helm version --short; kind version; minikube version; kustomize version; command -v kubectx; command -v kubens; k9s version'
zsh -ic 'git config --global --get core.pager'
```

```bash
brew outdated --json=v2
```

## Expected

- `python3` is `3.13.x`.
- `python3.14` exists as additional interpreter.
- `node` is `v24.x`.
- Bun is installed from tap `oven-sh/bun`.
- Flutter doctor reports no issues.
- AI CLI versions are returned successfully.
- Kubernetes tooling (`kubectl`, `helm`, `kind`, `minikube`, `kustomize`, `kubectx`, `kubens`, `k9s`) is present.
- `brew outdated` returns empty `formulae` and `casks`.

## Re-run policy

- Re-run `./install-macos.sh` any time after repo updates.
- The bootstrap is idempotent and safe to run repeatedly.
