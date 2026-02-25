# Module Reference

## Execution order on macOS

`scripts/bootstrap/os/darwin.sh` executes in this order:

1. `system/system-tools.sh` (`install_system_tools`)
2. `system/terminal-experience.sh` (`install_terminal_experience_stack`)
3. `system/stats.sh`
4. `system/containers.sh`
5. `technologies/kubernetes.sh`
6. `technologies/java.sh`
7. `technologies/js-ts.sh`
8. `technologies/python.sh`
9. `technologies/rust.sh`
10. `technologies/flutter.sh`
11. `technologies/cpp.sh`
12. `technologies/ai-cli.sh`
13. `system/shell-env.sh` (`configure_shell_env`)
14. `system/terminal-experience.sh` (`configure_terminal_experience`)

## Module map

| Domain | Module | Main installs |
| --- | --- | --- |
| System | `system-tools.sh` | bash, git, gh, jq, yq, rg, fzf, lazygit, lazydocker, httpie, ncdu, wget, tmux |
| System | `terminal-experience.sh` | `starship`, `atuin`, `git-delta`; `~/.config` templates; `~/.zshrc` prompt/history hooks |
| System | `stats.sh` | Stats (cask) with optional tuned profile and login item |
| Containers | `containers.sh` | OrbStack (cask), Docker CLI stack, Colima |
| Kubernetes | `kubernetes.sh` | `kubernetes-cli`, `helm`, `kustomize`, `kind`, `minikube`, `kubectx`, `k9s` |
| Java | `java.sh` | `openjdk@17` |
| JS/TS | `js-ts.sh` | Bun via `oven-sh/bun`, Node + `node@24`, TypeScript, Vitest, Playwright, Husky, Biome, ESLint, Prettier |
| Python | `python.sh` | `python@3.13` (default), `python@3.14` (additional), uv, ruff, mypy, pytest, pipx |
| Rust | `rust.sh` | rustup, stable toolchain, clippy, rustfmt, cargo-audit, cargo-deny, cargo-edit, cargo-generate, cargo-outdated, cargo-watch |
| Flutter/Mobile | `flutter.sh` | Flutter (cask), Android command line tools (cask), Android Studio (cask), CocoaPods, Chrome |
| C/C++ | `cpp.sh` | clang-format, llvm, cmake, ninja, ccache, conan, vcpkg, cppcheck, googletest, pkgconf |
| AI CLI | `ai-cli.sh` | Claude Code via official curl, OpenCode via official curl, Gemini CLI via brew, Codex via brew cask |
| Shell env | `shell-env.sh` | `JAVA_HOME`, Android vars, LLVM vars, PATH priorities, ccache vars |

## Core scripts

- Bootstrap entrypoint: `scripts/bootstrap/bootstrap.sh`
- macOS wrapper: `install-macos.sh`
- Shared helpers: `scripts/bootstrap/lib/common.sh`
