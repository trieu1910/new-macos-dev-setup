# JavaScript and TypeScript

## Module

- `scripts/bootstrap/modules/technologies/js-ts.sh`
- Script function: `install_node_stack`

## What it installs

- Runtime setup:
  - `bun` from `oven-sh/bun` tap
  - `node@24` if available
- JavaScript toolchain:
  - `typescript`
  - `tsx`
  - `ts-node`
  - `vitest`
  - `playwright`, `@playwright/test`
  - `husky`
  - `@biomejs/biome`
  - `prettier`
  - `eslint`

## Runtime policy

- Node 24 is force-linked (`brew link --overwrite --force node@24`) for consistent local runtime.

## Idempotency

- Installs use stable command checks and skip already-present packages.

## Verification

```bash
node --version
bun --version
zsh -ic 'bun install -g --help >/dev/null; echo bun ok'
```

