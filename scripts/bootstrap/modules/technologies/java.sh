#!/usr/bin/env bash
set -euo pipefail

install_java_stack() {
  if brew_formula_exists "openjdk@17"; then
    brew_install_formulas openjdk@17
  fi
}
