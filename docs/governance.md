# Governance

## Roles

- Maintainer:
  - Owns roadmap and release decisions
  - Reviews and merges pull requests
  - Owns security and policy decisions
- Contributors:
  - Propose and implement scoped improvements
  - Keep changes aligned with modular architecture

## Decision model

- Default: maintainer-led decisions with public rationale in PR discussion.
- Breaking behavior changes require explicit note in:
  - PR description
  - `CHANGELOG.md`
  - affected docs

## Stability contract

- `python3` default remains `3.13` unless explicitly changed.
- `node` active runtime remains `24.x` unless explicitly changed.
- Domain module boundaries are preserved.

## Release policy

- Small scoped changes are merged continuously.
- Changelog is updated per notable change.
- Version tag is cut by maintainer when release is ready.

## Communication

- Bugs and feature proposals go through GitHub Issues.
- Security reports are private and routed through `SECURITY.md`.
