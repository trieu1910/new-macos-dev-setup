# System Requirements

## Hardware and OS

- Apple Silicon Mac is the primary target.
- macOS 14+ is recommended.
- Internet connection is required for package downloads.
- At least 30 GB free disk space is recommended for full stack + caches.

## Accounts and Access

- Apple ID for Xcode and App Store assets.
- GitHub account for `gh` usage and SSH key-based Git.
- Network access to:
  - `github.com`
  - `raw.githubusercontent.com`
  - `claude.ai`
  - `opencode.ai`
  - Homebrew package mirrors

## Baseline System State

- Xcode Command Line Tools should be installed:
  - `xcode-select --install`
- No preinstalled package manager is required.
- Installer supports clean systems and existing systems.

## Shell

- `zsh` is expected for the managed shell profile.
- The bootstrap writes a managed env block into `~/.zshrc` using:
  - `BETTER_MACOS_ENV_VERSION=1`

## Security Expectations

- Some installers require admin password prompts.
- AI CLI authentication is performed after installation by each tool.
