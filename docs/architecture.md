# Architecture

## Overview

The project uses a modular bootstrap architecture:

- Entry wrapper: `install-macos.sh`
- Core orchestrator: `scripts/bootstrap/bootstrap.sh`
- OS dispatcher: `scripts/bootstrap/os/*.sh`
- Domain modules: `scripts/bootstrap/modules/**`
- Shared helpers: `scripts/bootstrap/lib/common.sh`

## Bootstrap flow

1. Parse CLI flags in `bootstrap.sh`.
2. Detect target OS (or accept `--os` override).
3. Load shared helpers.
4. Load OS module.
5. Execute domain modules in fixed order.
6. Run health checks.

## Domain isolation

- System and shell setup are isolated from language modules.
- Each technology domain has its own script.
- Modules are intended to remain idempotent and composable.

## Version control points

- JS runtime:
  - Bun from `oven-sh/bun`
  - Node active version pinned to `node@24`
- Python:
  - `python@3.13` linked as default `python3`
  - `python@3.14` installed as additional interpreter
- Rust:
  - rustup-managed stable toolchain

## Cross-platform strategy

- `darwin` module is production-ready.
- `linux` and `windows` modules are placeholders.
- Shared logic remains centralized in `lib/common.sh`.
