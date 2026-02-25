# Flutter and Mobile

## Module

- `scripts/bootstrap/modules/technologies/flutter.sh`
- Script function: `install_flutter_stack`

## What it installs

- Formula: `cocoapods`
- Casks: `flutter`, `android-commandlinetools`, `android-studio`, `google-chrome`

## Runtime checks

- Runs `flutter --version` after install.
- Runs `flutter config --no-analytics` to align default telemetry behavior.

## Idempotency

- Formula/cask operations are skipped when already present.
- Commands are only executed when `flutter` is available.

## Verification

```bash
flutter --version
flutter doctor -v | rg "No issues found|\\[✗\\]"
```

