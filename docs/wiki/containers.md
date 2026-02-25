# Containers

## Module

- `scripts/bootstrap/modules/system/containers.sh`
- Script function: `install_container_stack`

## What it installs

- Formulas: `colima`, `docker`, `docker-compose`, `docker-credential-helper`
- Cask: `orbstack`

## Runtime behavior

- Docker CLI stack is installed and wired.
- If `docker` and `orbctl` are available, bootstrap applies deterministic context selection:
  - `orbstack` first (preferred)
  - `colima` as fallback
- `--start-orbstack` starts OrbStack at the end of bootstrap and re-applies OrbStack context when possible.

## Idempotency

- Existing formulas and casks are skipped.
- `orbctl start` is only executed when requested via `--start-orbstack`.

## Verification

```bash
docker context ls
orbctl status
docker context use orbstack || docker context use colima
```
