# System Tools

## Module

- `scripts/bootstrap/modules/system/system-tools.sh`
- Script function: `install_system_tools`

## What it installs

- `bash`, `bat`, `curl`, `direnv`, `eza`, `fd`, `fzf`
- `git`, `gh`, `gnu-sed`, `htop`, `httpie`, `jq`, `lazygit`, `lazydocker`
- `ncdu`, `ripgrep`, `tmux`, `tree`, `wget`, `yq`, `zoxide`

## Why it exists

- Provides baseline developer utilities used by all language runtimes and bootstrap tasks.

## Idempotency

- Each formula is installed only if missing.
- This module delegates actual install behavior to shared helpers in `scripts/bootstrap/lib/common.sh`.

## Verification

```bash
brew list --formula bash bat curl direnv eza fd fzf git gh gnu-sed htop httpie jq lazygit lazydocker ncdu rg tmux tree wget yq zoxide
```

