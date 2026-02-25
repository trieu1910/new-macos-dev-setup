#!/usr/bin/env bash
set -euo pipefail

configure_shell_env() {
  local zshrc="${HOME}/.zshrc"
  if [[ ! -f "$zshrc" ]]; then
    if [[ "${DRY_RUN:-0}" == "1" ]]; then
      log "DRY-RUN: touch ${zshrc}"
    else
      touch "$zshrc"
    fi
  fi

  if grep -q '^export BETTER_MACOS_ENV_VERSION=1$' "$zshrc"; then
    log "shell env already configured"
    return
  fi

  if [[ "${DRY_RUN:-0}" == "1" ]]; then
    log "DRY-RUN: append shell env to ${zshrc}"
    return
  fi

  cat >> "$zshrc" <<'EOF'
export BETTER_MACOS_ENV_VERSION=1
export JAVA_HOME="/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home"
export ANDROID_HOME="/opt/homebrew/share/android-commandlinetools"
export ANDROID_SDK_ROOT="/opt/homebrew/share/android-commandlinetools"
export LLVM_HOME="/opt/homebrew/opt/llvm"
export PATH="$HOME/.local/bin:$HOME/.opencode/bin:$HOME/.bun/bin:$HOME/.cargo/bin:/opt/homebrew/opt/node@24/bin:/opt/homebrew/opt/openjdk@17/bin:$LLVM_HOME/bin:/opt/homebrew/opt/ccache/libexec:$PATH"
export CMAKE_GENERATOR="Ninja"
export CCACHE_DIR="$HOME/.cache/ccache"
export CCACHE_MAXSIZE="20G"
export CCACHE_COMPRESS="true"
EOF
}
