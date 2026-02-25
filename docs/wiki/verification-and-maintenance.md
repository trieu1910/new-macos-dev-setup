# Verification and Maintenance

## Scope

This page mirrors full-system checks defined in the module-level scripts.

## Critical state checks

```bash
zsh -ic 'node --version; bun --version; python3 --version; python3.14 --version; uv --version; rustc --version; cargo --version; java -version'
zsh -ic 'claude --version; opencode --version; gemini --version; codex --version'
zsh -ic 'starship --version; atuin --version; delta --version; command -v cargo-add'
zsh -ic 'kubectl version --client=true; helm version --short; kind version; minikube version; kustomize version; command -v kubectx; command -v kubens; k9s version'
```

## Git delta and shell checks

```bash
zsh -ic 'git config --global --get core.pager; git config --global --get pager.diff; git config --global --get pager.show'
rg -n 'eval "\\$\\(starship init zsh\\)"|eval "\\$\\(atuin init zsh\\)"|BETTER_MACOS_ENV_VERSION' ~/.zshrc
```

## Repository hygiene

```bash
git check-ignore -v .serena .claude AGENTS.md CLAUDE.md
```

## Maintenance policy

- Re-run `./install-macos.sh` after stack updates or drift corrections.
- Use `--with-stats --configure-stats` for optional desktop tuning.
