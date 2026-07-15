---
name: windows-cpp
description: Fast Windows C++ create/compile/run workflow with MSVC first and MinGW g++ fallback. Use this whenever the user asks to write, build, run, or debug C++ code on Windows, especially when compiler setup or PATH issues may block progress.
disable-model-invocation: true
---

# windows-cpp

Use this workflow to compile C++ reliably on Windows.

## Toolchain selection
1. Prefer **MSVC** (`cl`) when Visual Studio Build Tools or Visual Studio is installed.
2. Use **MinGW g++** fallback when `cl` is unavailable.

## MSVC path (preferred)
1. Open **Developer Command Prompt for VS** (or load vcvars in current shell).
2. Compile:
   - `cl /EHsc /std:c++17 main.cpp`
3. Run:
   - `.\main.exe`

## MinGW g++ path (fallback)
1. Ensure `g++ --version` works.
2. Compile:
   - `g++ -std=c++17 -O2 -Wall -Wextra -o main.exe main.cpp`
3. Run:
   - `.\main.exe`

## Fast failure recovery (Windows)
- If `cl` is not recognized:
  - Switch to Developer Command Prompt for VS and retry.
- If `g++` is not recognized:
  - Install MinGW-w64 and add its `bin` directory to `PATH`, then open a new shell.
- If linker errors mention missing runtime/libs:
  - Re-run from the correct toolchain shell (do not mix shells/toolchains mid-build).
- If source has UTF-8 text issues:
  - Prefer saving source as UTF-8 and keep compile commands unchanged unless project requires explicit encoding flags.

## Output expectations
- Always state which toolchain is being used.
- Provide exact compile + run commands in order.
- Keep instructions short and executable without extra interpretation.
