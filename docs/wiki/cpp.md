# C and C++

## Module

- `scripts/bootstrap/modules/technologies/cpp.sh`
- Script function: `install_cpp_stack`

## What it installs

- `clang-format`, `llvm`, `cmake`, `ninja`, `ccache`, `conan`, `vcpkg`, `cppcheck`, `googletest`, `pkgconf`

## Purpose

- Build toolchain, package management, and static/runtime quality tooling for native projects.

## Verification

```bash
clang --version
cmake --version
ninja --version
```

