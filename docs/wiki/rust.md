# Rust

## Module

- `scripts/bootstrap/modules/technologies/rust.sh`
- Script function: `install_rust_stack`

## What it installs

- `rustup` + stable toolchain
- Components: `clippy`, `rustfmt`
- Cargo extras:
  - `cargo-audit`
  - `cargo-deny`
  - `cargo-edit`
  - `cargo-generate`
  - `cargo-outdated`
  - `cargo-watch`

## `cargo-edit` installation behavior

- `cargo-edit` is represented by `cargo-add` and other subcommands, so bootstrap verifies `command -v cargo-add` before attempting install.

## Idempotency

- Skips already installed components and crates when detected.
- Uses `cargo install --list` to avoid duplicate installations.

## Verification

```bash
rustc --version
cargo --version
cargo install --list | rg '^cargo-(audit|deny|generate|outdated|watch|edit|add)'
```

