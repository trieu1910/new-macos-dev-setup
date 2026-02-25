# Troubleshooting

## Homebrew not found or broken

Run:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew doctor
```

Then re-run installer.

## `node` is not 24.x after install

Run:

```bash
brew link --overwrite --force node@24
node --version
```

## `python3` is not 3.13

Run:

```bash
brew link --overwrite --force python@3.13
python3 --version
```

## `opencode` not found in non-interactive shell

Installer places `opencode` under `~/.opencode/bin`.

Run:

```bash
source ~/.zshrc
zsh -ic 'opencode --version'
```

## Flutter doctor reports Android/Xcode issues

Run:

```bash
xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
flutter doctor -v
```

If Android SDK licenses are pending:

```bash
flutter doctor --android-licenses
```

## Docker context is not OrbStack

Run:

```bash
docker context use orbstack
orbctl start
docker context ls
docker context use colima
```

If neither context exists, run a clean bootstrap for container modules:

```bash
./install-macos.sh --skip-health-check
```

## Kubernetes CLI/tooling missing or not found

Run:

```bash
brew update
brew install kubernetes-cli helm kustomize kind minikube kubectx k9s
kubectl version --client=true
helm version --short
kind version
minikube version
```

## kind/minikube cluster commands fail

Run:

```bash
kind get clusters
minikube status
docker context ls
```

If Docker runtime is not available, start a container runtime first (OrbStack/Docker context or Colima) and re-run `install-macos.sh`.

Deterministic recovery sequence:

```bash
docker context ls
docker context use orbstack || docker context use colima
if command -v orbctl >/dev/null 2>&1; then orbctl start; fi
kind delete cluster --name test || true
kind create cluster --name test
```

## Wrong Gemini package installed

`gemini` cask is a GUI cleaner app, not Gemini CLI.

Run:

```bash
brew uninstall --cask gemini || true
brew install gemini-cli
gemini --version
```
