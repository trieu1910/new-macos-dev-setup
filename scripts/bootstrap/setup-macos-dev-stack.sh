#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly REPO_DIR="20 20 12 61 79 80 81 33 98 100 204 250 395 398 399 400 701cd "/../.." && pwd)"
readonly BREWFILE="${REPO_DIR}/Brewfile"
readonly ZSHRC="${HOME}/.zshrc"

readonly DEFAULT_GIT_NAME="Danil Silantyev"
readonly DEFAULT_GIT_EMAIL="danilsilantyevwork@gmail.com"

START_ORBSTACK=0
DRY_RUN=0
FORCE_YES=0
SKIP_HEALTH_CHECK=0

log() { printf "[bootstrap] %s\n" "$*"; }
warn() { printf "[bootstrap][warn] %s\n" "$*" >&2; }
err() { printf "[bootstrap][error] %s\n" "$*" >&2; }

require_cmd() {
  command -v "$1" >/dev/null 2>&1
}

run() {
  if [[ "$DRY_RUN" == "1" ]]; then
    log "DRY-RUN: $*"
  else
    eval "$*"
  fi
}

ensure_homebrew() {
  if require_cmd brew; then
    log "Homebrew already installed"
    return
  fi

  log "Homebrew not found. Installing..."
  run "/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
  run "eval \"$(/opt/homebrew/bin/brew shellenv)\""
}

ensure_brew_file_install() {
  if [[ ! -f "$BREWFILE" ]]; then
    err "Brewfile not found: $BREWFILE"
    exit 1
  fi

  log "Syncing Homebrew packages via Brewfile"
  run "brew bundle install --file '$BREWFILE'"
}

configure_shell_profile() {
  local marker="# better-macOS dev-stack"
  if [[ ! -f "$ZSHRC" ]]; then
    run "touch '$ZSHRC'"
  fi

  if grep -q "^${marker}$" "$ZSHRC"; then
    log "Shell profile already contains better-macOS block"
    return
  fi

  cat >> "$ZSHRC" <<'EOF_ZSH'
# better-macOS dev-stack
export BUN_BIN="${HOME}/.bun/bin"
export JAVA_HOME="/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home"
export ANDROID_HOME="/opt/homebrew/share/android-commandlinetools"
export ANDROID_SDK_ROOT="/opt/homebrew/share/android-commandlinetools"
export LLVM_HOME="/opt/homebrew/opt/llvm"
export PATH="${HOME}/.local/bin:${HOME}/.bun/bin:${HOME}/.cargo/bin:${HOME}/.cache/bin:${LLVM_HOME}/bin:${PATH}"
export PATH="/opt/homebrew/opt/ccache/libexec:${PATH}"
export PATH="/opt/homebrew/opt/openjdk@17/bin:${PATH}"
export PATH="${ANDROID_HOME}/platform-tools:${PATH}"
export CMAKE_GENERATOR="Ninja"
export CCACHE_DIR="${HOME}/.cache/ccache"
export CCACHE_MAXSIZE="20G"
export CLANG_TIDY="${LLVM_HOME}/bin/clang-tidy"
export CLANGD="${LLVM_HOME}/bin/clangd"
EOF_ZSH

  log "Appended dev-stack configuration to ~/.zshrc"
}

ensure_orbstack_context() {
  if ! require_cmd docker; then
    warn "docker not found; skipping docker context check"
    return
  fi

  if require_cmd orb; then
    log "OrbStack binary found: $(orb version 2>/dev/null || true)"
  fi

  if require_cmd docker && require_cmd orbctl; then
    if (( START_ORBSTACK == 1 )); then
      if docker context show >/dev/null 2>&1; then
        run "docker context use orbstack"
      fi
      run "orbctl start"
      log "OrbStack context set and service started"
    else
      run "docker context use orbstack" || true
    fi
  fi
}

configure_git_identity() {
  local current_name current_email
  current_name=$(git config --global user.name || true)
  current_email=$(git config --global user.email || true)

  if [[ -z "$current_name" ]]; then
    run "git config --global user.name '$DEFAULT_GIT_NAME'"
    log "Set git user.name = $DEFAULT_GIT_NAME"
  fi

  if [[ -z "$current_email" ]]; then
    run "git config --global user.email '$DEFAULT_GIT_EMAIL'"
    log "Set git user.email = $DEFAULT_GIT_EMAIL"
  fi
}

setup_post_checks() {
  log "Verifying critical binaries"
  local items=(\
    bun \
    node \
    python3.13 \
    uv \
    flutter \
    dart \
    rustc \
    cargo \
    clang \
    clang++ \
    clangd \
    clang-tidy \
    ccache \
    cmake \
    ninja \
    conan \
    vcpkg \
    jq \
    yq \
    rg \
    fzf \
    lazygit \
    lazydocker \
    docker \
    gh \
    git\n  )
  for item in "${items[@]}"; do
    if require_cmd "$item"; then
      printf "  - %-12s: " "$item"
      case "$item" in
        bun|rustc|cargo|clang|clang++|clangd|clang-tidy|cmake|ninja|conan|vcpkg|uv|java|jq|yq|rg|fzf|lazygit|lazydocker|docker|gh|git)
          "${item} --version" | sed 's/^/  /' ;;
        node)
          "$item" --version | sed 's/^/  /';;
        python3.13)
          "$item" --version | sed 's/^/  /';;
        flutter)
          "${item}" --version | head -n 1 | sed 's/^/  /';;
        *)
          if "$item" --version >/tmp/bootstrap.version.$$ 2>&1; then
            sed -n '1p' /tmp/bootstrap.version.$$ | sed 's/^/  /'
            rm -f /tmp/bootstrap.version.$$
          else
            printf "  (no version output)\n"
          fi
          ;;
      esac
    else
      printf "  - %-12s: absent\n" "$item"
    fi
  done
}

show_help() {
  cat <<'EOF_HELP'
Usage: ./scripts/bootstrap/setup-macos-dev-stack.sh [options]

Options:
  --start-orbstack       Start OrbStack and switch docker context to it.
  --dry-run              Print commands without executing.
  --skip-health-check    Skip post installation verification.
  --help                 Show this help.

Environment variables:
  FORCE_YES: set to 1 to avoid interactive prompts where supported.
EOF_HELP
}

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --start-orbstack)
      START_ORBSTACK=1
      ;;
    --dry-run)
      DRY_RUN=1
      ;;
    --skip-health-check)
      SKIP_HEALTH_CHECK=1
      ;;
    --help)
      show_help
      exit 0
      ;;
    *)
      err "Unknown argument: $1"
      show_help
      exit 1
      ;;
  esac
  shift
 done

[[ "${DRY_RUN}" == "1" ]] && log "Running in dry-run mode"

if [[ "$(uname)" != "Darwin" ]]; then
  err "This script is for macOS only."
  exit 1
fi

ensure_homebrew
ensure_brew_file_install
configure_shell_profile
configure_git_identity
ensure_orbstack_context

# Keep OpenJDK shim and LLVM helpers prioritized for deterministic CLI behavior.
if require_cmd brew; then
  run "brew link --overwrite --force openjdk@17"
  run "brew link --overwrite --force llvm" || true
fi

if [[ "$SKIP_HEALTH_CHECK" == "0" ]]; then
  setup_post_checks
fi

log "Bootstrap finished. Source ~/.zshrc in new shell or run: source ~/.zshrc"
