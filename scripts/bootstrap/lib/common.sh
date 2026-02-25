#!/usr/bin/env bash
set -euo pipefail

run() {
  if [[ "${DRY_RUN:-0}" == "1" ]]; then
    log "DRY-RUN: $*"
    return 0
  fi
  "$@"
}

log() {
  printf '[bootstrap] %s\n' "$*"
}

log_error() {
  printf '[bootstrap][error] %s\n' "$*" >&2
}

has() {
  command -v "$1" >/dev/null 2>&1
}

ensure_homebrew() {
  if has brew; then
    run brew update
    return
  fi
  run /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
    export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
  fi
  if ! has brew; then
    log_error "Homebrew installation failed"
    exit 1
  fi
}

brew_formula_exists() {
  brew info --formula "$1" >/dev/null 2>&1
}

brew_cask_exists() {
  brew info --cask "$1" >/dev/null 2>&1
}

brew_install_formulas() {
  for package in "$@"; do
    if brew list --formula "$package" >/dev/null 2>&1; then
      log "$package already present"
      continue
    fi
    run brew install "$package"
  done
}

brew_install_casks() {
  for package in "$@"; do
    if brew list --cask "$package" >/dev/null 2>&1; then
      log "$package already present"
      continue
    fi
    run brew install --cask "$package"
  done
}

brew_cask_installed() {
  brew list --cask "$1" >/dev/null 2>&1
}

brew_uninstall_formula() {
  local package=$1
  if brew list --formula "$package" >/dev/null 2>&1; then
    run brew uninstall --ignore-dependencies --formula "$package"
  fi
}

brew_uninstall_cask() {
  local package=$1
  if brew_cask_installed "$package"; then
    run brew uninstall --cask "$package"
  fi
}

print_health_checks() {
  local checks=(
    bun
    node
    flutter
    dart
    python3.13
    uv
    rustc
    cargo
    clang
    clang++
    clangd
    llvm-profdata
    ccache
    cmake
    ninja
    conan
    vcpkg
    gh
    git
    jq
    yq
    rg
    fzf
    lazygit
    lazydocker
    docker
    orbctl
    claude
    opencode
    gemini
    codex
    java
  )

  for item in "${checks[@]}"; do
    if has "$item"; then
      printf '%s: ' "$item"
      "$item" --version 2>/dev/null | head -n 1
    else
      printf '%s: missing\n' "$item"
    fi
  done
}
