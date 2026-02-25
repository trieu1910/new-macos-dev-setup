# Python

## Module

- `scripts/bootstrap/modules/technologies/python.sh`
- Script function: `install_python_stack`

## What it installs

- `python@3.13` linked as active interpreter
- `python@3.14` as additional interpreter
- `uv`, `ruff`, `mypy`, `pytest`, `pipx`

## Version policy

- Bootstrap enforces `python3` from `python@3.13`.
- `python@3.14` remains installed for projects needing modern runtime.

## Idempotency

- Formulas are installed via shared helper and skipped when already present.

## Verification

```bash
python3 --version
python3.14 --version
uv --version
```

