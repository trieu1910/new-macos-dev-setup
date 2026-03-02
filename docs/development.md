# Development Guide

## Goal

Provide a single local quality gate that mirrors CI checks before opening a pull request.

## Local prerequisites

- `bash`
- `shellcheck`
- `actionlint`
- `node` + `npx` (for markdown lint)

## Commands

Run from repository root:

```bash
make help
```

Full quality gate:

```bash
make check
```

Individual checks:

```bash
make syntax-shell
make lint-shell
make lint-workflows
make lint-docs
make smoke
```

## CI parity

`make check` maps directly to the CI workflow quality gates:

- shell lint
- shell syntax
- workflow lint
- docs lint
- bootstrap smoke
