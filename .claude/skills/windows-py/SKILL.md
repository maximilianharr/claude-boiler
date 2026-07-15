---
name: windows-py
description: Fast Windows Python setup/run workflow using Conda. Use this whenever the user asks to create, run, debug, or scaffold Python code on Windows, especially when environment activation or missing-conda issues are likely.
---

# windows-py

Use this workflow to keep Python execution reliable on Windows.

## Default execution path
1. Create files first (`main.py`, package files, or requested project layout).
2. Run Python from an activated Conda environment:
   - `conda activate test_env`
   - `python main.py`
3. If the task includes tests, run them in the same activated environment.

## Command patterns
- Single file script:
  - `conda activate test_env`
  - `python script.py`
- Module execution:
  - `conda activate test_env`
  - `python -m package.module`

## Fast failure recovery (Windows)
- If `conda` is not recognized:
  - Try initializing shell support first: `conda init powershell`
  - Open a new shell and retry `conda activate test_env`
  - If still unavailable, run via Anaconda Prompt / Miniconda Prompt.
- If environment `test_env` does not exist:
  - `conda create -n test_env python=3.11 -y`
  - `conda activate test_env`
- If Python package import fails, report the missing package and install it in the active env before retrying.

## Output expectations
- Always provide the exact commands used, in execution order.
- Keep commands Windows-native (PowerShell/cmd friendly).
- Prefer short, deterministic run instructions over long environment theory.
