#!/usr/bin/env bash
set -euo pipefail

install_ai_cli_stack() {
  if ! has claude; then
    run bash -c "curl -fsSL https://claude.ai/install.sh | bash"
  fi

  if ! has opencode && [[ ! -x "${HOME}/.opencode/bin/opencode" ]]; then
    run bash -c "curl -fsSL https://opencode.ai/install | bash"
  fi

  if brew_cask_installed "gemini"; then
    brew_uninstall_cask "gemini"
  fi

  if brew_formula_exists "gemini-cli"; then
    brew_install_formulas gemini-cli
    if brew_list_contains_formula "node@24"; then
      run brew link --overwrite --force node@24
    fi
  fi

  if brew_list_contains_formula codex; then
    brew_uninstall_formula codex
  fi

  if brew_cask_exists "codex"; then
    brew_install_casks "codex"
  elif brew_formula_exists "codex"; then
    brew_install_formulas "codex"
  fi

  if has claude; then
    run claude --version
  fi

  if has opencode; then
    run opencode --version
  elif [[ -x "${HOME}/.opencode/bin/opencode" ]]; then
    run "${HOME}/.opencode/bin/opencode" --version
  fi
}

brew_list_contains_formula() {
  brew list --formula "$1" >/dev/null 2>&1
}
