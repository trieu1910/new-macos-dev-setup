#!/usr/bin/env bash
set -euo pipefail

install_flutter_stack() {
  local formulae=(
    flutter
    cocoapods
    android-commandlinetools
  )
  local casks=(
    google-chrome
  )
  local selected_formulae=()

  for package in "${formulae[@]}"; do
    if brew_formula_exists "$package"; then
      selected_formulae+=("$package")
    fi
  done

  if [[ "${#selected_formulae[@]}" -gt 0 ]]; then
    brew_install_formulas "${selected_formulae[@]}"
  fi

  for package in "${casks[@]}"; do
    if brew_cask_exists "$package"; then
      brew_install_casks "$package"
    fi
  done

  if has flutter; then
    run flutter --version
    run flutter config --no-analytics
  fi
}
