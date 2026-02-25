# Verification Guide

## Full bootstrap verification

Run:

```bash
cd /Users/rldyourmnd/projects/new-macos-dev-setup
./install-macos.sh
```

The final health output should not show missing tools for the expected stack.

## Critical version checks

```bash
zsh -ic 'node --version; bun --version; python3 --version; python3.14 --version; uv --version; rustc --version; cargo --version; java -version'
```

Expected profile:

- `node`: `v24.x`
- `python3`: `3.13.x`
- `python3.14`: present as additional interpreter
- `bun`: installed from Homebrew tap `oven-sh/bun`

## Mobile stack checks

```bash
zsh -ic 'flutter --version; flutter doctor -v | rg "No issues found|\\[✗\\]"'
```

Expected:

- `flutter doctor -v` ends with `No issues found!`

## AI CLI checks

```bash
zsh -ic 'claude --version; opencode --version; gemini --version; codex --version'
```

Expected:

- All commands return versions.

## Container checks

```bash
zsh -ic 'docker --version; docker context ls; orbctl status'
```

Expected:

- `orbstack` context exists.
- OrbStack status is `Running` when started.

## Homebrew state checks

```bash
brew outdated --json=v2
```

Expected:

- Empty `formulae` and `casks` arrays for fully up-to-date state.
