# Java

## Module

- `scripts/bootstrap/modules/technologies/java.sh`
- Script function: `install_java_stack`

## What it installs

- `openjdk@17`

## Runtime effect

- `shell-env.sh` sets `JAVA_HOME` for `openjdk@17` and prepends it to PATH in `~/.zshrc`.

## Verification

```bash
java -version
```

