#!/usr/bin/env bash
set -euo pipefail

install_kubernetes_stack() {
  local formulae=(
    kubernetes-cli
    helm
    kustomize
    kind
    minikube
    kubectx
    k9s
  )
  local selected_formulae=()

  for package in "${formulae[@]}"; do
    if brew_formula_exists "$package"; then
      selected_formulae+=("$package")
    fi
  done

  if [[ "${#selected_formulae[@]}" -gt 0 ]]; then
    brew_install_formulas "${selected_formulae[@]}"
  fi

  if has kubectl; then
    run kubectl version --client=true >/dev/null 2>&1 || true
  fi
  if has helm; then
    run helm version --short >/dev/null 2>&1 || true
  fi
  if has kustomize; then
    run kustomize version >/dev/null 2>&1 || true
  fi
  if has kind; then
    run kind version >/dev/null 2>&1 || true
  fi
  if has kubectx; then
    run kubectl config get-contexts >/dev/null 2>&1 || true
  fi
  if has k9s; then
    run k9s version >/dev/null 2>&1 || true
  fi
  if has minikube; then
    run minikube version >/dev/null 2>&1 || true
  fi
}
