#!/usr/bin/env bash
set -euo pipefail

install_rust_stack() {
  if brew_formula_exists "rustup"; then
    brew_install_formulas rustup
  fi

  if ! has rustup; then
    run bash -c "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"
  fi

  if [[ -f "${HOME}/.cargo/env" ]]; then
    . "${HOME}/.cargo/env"
  fi

  if has rustup; then
    run rustup toolchain install stable
    run rustup default stable
    run rustup component add clippy
    run rustup component add rustfmt
  fi

  if has cargo; then
    install_rust_cargo_extras
  fi
}

install_rust_cargo_extras() {
  local crates=(
    cargo-audit
    cargo-deny
    cargo-edit
    cargo-generate
    cargo-outdated
    cargo-watch
  )
  local installed
  local crate

  installed="$(cargo install --list 2>/dev/null || true)"

  for crate in "${crates[@]}"; do
    if [[ "$crate" == "cargo-edit" ]]; then
      if command -v cargo-add >/dev/null 2>&1; then
        log "cargo-edit toolchain already present"
        continue
      fi
    fi

    if printf '%s\n' "$installed" | rg -q "^${crate} v"; then
      log "$crate already present"
      continue
    fi
    run cargo install --locked "$crate"
  done
}
