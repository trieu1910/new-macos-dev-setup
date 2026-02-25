#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
START_ORBSTACK=0
SKIP_HEALTH_CHECK=0
DRY_RUN=0
TARGET_OS=""

show_help() {
  cat <<'EOF'
Usage: ./scripts/bootstrap/bootstrap.sh [options]

Options:
  --start-orbstack            Start OrbStack and switch docker context to it.
  --skip-health-check          Skip final health check.
  --dry-run                    Print commands without executing.
  --os [darwin|linux|windows]  Select OS module explicitly.
  --help                       Show this help message.
EOF
}

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --start-orbstack)
      START_ORBSTACK=1
      ;;
    --skip-health-check)
      SKIP_HEALTH_CHECK=1
      ;;
    --dry-run)
      DRY_RUN=1
      ;;
    --os)
      shift
      if [[ "$#" -eq 0 ]]; then
        show_help
        exit 1
      fi
      TARGET_OS="$1"
      ;;
    --help|-h)
      show_help
      exit 0
      ;;
    *)
      show_help
      exit 1
      ;;
  esac
  shift
done

source "${SCRIPT_DIR}/lib/common.sh"

if [[ -z "$TARGET_OS" ]]; then
  case "$(uname -s)" in
    Darwin)
      TARGET_OS=darwin
      ;;
    Linux)
      TARGET_OS=linux
      ;;
    CYGWIN*|MINGW*|MSYS*)
      TARGET_OS=windows
      ;;
    *)
      TARGET_OS=darwin
      ;;
  esac
fi

if [[ "$DRY_RUN" == "1" ]]; then
  log "Running in dry-run mode"
fi

OS_BOOTSTRAP_FILE="${SCRIPT_DIR}/os/${TARGET_OS}.sh"
if [[ ! -f "$OS_BOOTSTRAP_FILE" ]]; then
  log "Unsupported OS: $TARGET_OS"
  exit 1
fi

source "$OS_BOOTSTRAP_FILE"

bootstrap_${TARGET_OS}

if [[ "$SKIP_HEALTH_CHECK" == "0" ]]; then
  print_health_checks
fi

log "Done"
