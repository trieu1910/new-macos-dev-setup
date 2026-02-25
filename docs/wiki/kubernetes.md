# Kubernetes

## Module

- `scripts/bootstrap/modules/technologies/kubernetes.sh`
- Script function: `install_kubernetes_stack`

## What it installs

- `kubernetes-cli` (provides `kubectl`)
- `helm`
- `kustomize`
- `kind` (local Kubernetes in Docker)
- `minikube`
- `kubectx` (includes `kubens`)
- `k9s` (terminal UI for Kubernetes)

## Operational notes

- These tools are installed via Homebrew and are skipped if already present.
- The stack is runtime-oriented and assumes Docker (or equivalent container runtime) is already available.
- The module validates minimal runtime health right after install:
  - `kubectl` client version
  - `helm` short version
  - `kind` and `minikube` versions
  - `kustomize` version

## Idempotency

- Each formula is installed only if missing.
- Version checks are best-effort and do not block install on failure in best-effort mode.

## Verification

```bash
kubectl version --client=true
helm version --short
kind version
minikube version
command -v kubectx
command -v kubens
k9s version
kustomize version
```

## Quick local checks

```bash
kubectl cluster-info
kind get clusters
helm env
```
