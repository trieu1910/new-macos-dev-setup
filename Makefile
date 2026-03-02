SHELL := /usr/bin/env bash
.SHELLFLAGS := -euo pipefail -c
.DEFAULT_GOAL := help

.PHONY: help check lint-shell syntax-shell lint-workflows lint-docs smoke

help:
	@printf "Available targets:\n"
	@printf "  check           Run full local quality gate (lint + syntax + smoke)\n"
	@printf "  lint-shell      Run shellcheck on bootstrap scripts\n"
	@printf "  syntax-shell    Run bash -n checks on shell scripts\n"
	@printf "  lint-workflows  Lint GitHub Actions workflows with actionlint\n"
	@printf "  lint-docs       Lint Markdown files\n"
	@printf "  smoke           Run lightweight bootstrap smoke checks\n"

check: syntax-shell lint-shell lint-workflows lint-docs smoke

lint-shell:
	@command -v shellcheck >/dev/null || { echo "shellcheck is required"; exit 1; }
	find scripts -type f -name "*.sh" -print0 | xargs -0 -n1 shellcheck -x -e SC1090,SC1091,SC2034,SC2086
	shellcheck -x -e SC1090,SC1091,SC2034,SC2086 install-macos.sh

syntax-shell:
	find scripts -type f -name "*.sh" -print0 | xargs -0 -n1 bash -n
	bash -n install-macos.sh

lint-workflows:
	@command -v actionlint >/dev/null || { echo "actionlint is required"; exit 1; }
	actionlint -color

lint-docs:
	@command -v npx >/dev/null || { echo "npx is required (install Node.js)"; exit 1; }
	npx --yes markdownlint-cli@0.45.0 --config .markdownlint.yml "**/*.md"

smoke:
	./install-macos.sh --help
	./scripts/bootstrap/bootstrap.sh --help
	./scripts/bootstrap/setup-macos-dev-stack.sh --help
	./scripts/bootstrap/bootstrap.sh --os linux --skip-health-check
