# Release Process

## Release inputs

- Merged PRs on `main`
- Updated `CHANGELOG.md`
- Updated docs for behavior/version changes

## Pre-release checklist

1. Ensure `CHANGELOG.md` has accurate entries.
2. Ensure major defaults are documented:
   - `python3` default
   - `node` active version
3. Ensure docs links are valid.
4. Ensure release notes are prepared in `docs/releases/<version>.md`.
5. Ensure repository is clean (except expected generated artifacts).

## Versioning

- Use Semantic Versioning.
- Tag format: `vMAJOR.MINOR.PATCH`.

## Active release target

- `v0.0.3`: OSS hardening release (CI security, dependency review, contributor quality gates, documentation portability).
- Planning source: `docs/releases/0.0.3.md`.

## Cut release

```bash
git checkout main
git pull
./install-macos.sh --skip-health-check
git tag -a vX.Y.Z -m "release: vX.Y.Z"
git push origin vX.Y.Z
```

## Post-release

1. Create next `Unreleased` section in `CHANGELOG.md` if needed.
2. Announce notable changes in release notes.
