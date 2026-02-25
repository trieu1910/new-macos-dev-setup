# better-macOS

A professional macOS developer bootstrap repository for a high-performance local environment.

## Цели

- Стандартизировать установку инструментов на новой macOS машине.
- Зафиксировать стек по языкам/направлениям (frontend, backend, mobile, systems).
- Автоматизировать повторяемую установку через `brew` + bootstrap-скрипт.

## Что включено

### Core tooling
- GitHub CLI, Git, Bun + Node-совместимый runtime, Python 3.13 + uv, Rust, OpenJDK 17.

### Containers
- Docker CLI + compose + credential helper.
- OrbStack как runtime (практичный и быстрый для macOS).

### Frontend / Web
- Базовые утилиты для TS/JS и JSON/YAML обработки.

### Mobile
- Flutter + Android command line tools.

### Systems / C/C++
- CMake + Ninja, Conan, vcpkg, LLVM toolchain, ccache, cppcheck, GoogleTest.

### Operability
- `lazygit`, `lazydocker`, `tmux`, `zoxide`, `fzf`, `rg`, `jq`, `yq`, `tree`, и др.

## Быстрый старт

```bash
cd /Users/rldyourmnd/projects/better-macOS
./scripts/bootstrap/setup-macos-dev-stack.sh
```

Опционально для контейнеров:

```bash
./scripts/bootstrap/setup-macos-dev-stack.sh --start-orbstack
```

## Структура

- `Brewfile` — единственный источник truth для Homebrew-пакетов.
- `scripts/bootstrap/setup-macos-dev-stack.sh` — идемпотентный bootstrap скрипт.

## Примечание по безопасности

Скрипт не удаляет пакеты и не трогает настройки системы без прямого вызова. Перед любыми изменениями в текущем окружении лучше запускать с `--dry-run`.
