# Terminal UX

## Module

- `scripts/bootstrap/modules/system/terminal-experience.sh`
- Script function: `configure_terminal_experience`

## What it does

- Installs `starship`, `atuin`, and `delta` (if available as Homebrew formulas).
- Syncs templates:
  - `scripts/bootstrap/templates/terminal/starship.toml`
  - `scripts/bootstrap/templates/terminal/atuin.toml`
- Ensures `~/.zshrc` includes:
  - `eval "$(starship init zsh)"`
  - `eval "$(atuin init zsh)"`
- Configures Git delta pager defaults:
  - `core.pager=delta`
  - `pager.diff=delta`
  - `pager.show=delta`
  - `interactive.diffFilter="delta --color-only"`

## Idempotency

- Prompt/history init lines are added only if absent.
- Legacy marker/comment lines are cleaned up before append to avoid duplicates.

## Verification

```bash
starship --version
atuin --version
delta --version
git config --global --get core.pager
```

