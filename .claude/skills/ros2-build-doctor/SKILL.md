---
name: ros2-build-doctor
description: Diagnose and fix ROS2 build failures, then optimize ROS2 developer build speed and reliability in generic workspaces. Use this whenever the user mentions ROS2 `colcon`, `ament_cmake`, `ament_python`, ROS2 `package.xml`, ROS2 `CMakeLists.txt`, ROS2 `setup.py` or `setup.cfg`, missing ROS2 dependencies, overlay or sourcing issues, slow ROS2 rebuilds, or asks why a ROS2 workspace will not build. Also use it when the user asks for safer ROS2 build hygiene or faster iteration loops, even if they do not explicitly ask for a "skill."
---

# ROS2 Build Doctor

Use this skill for standard ROS2 workspaces that build with `colcon` and contain `ament_cmake` and/or `ament_python` packages.

Your job is to investigate first, make the smallest high-confidence fix second, and only then optimize the build if it is sensible to do so.

## What success looks like

Help the user get from "this ROS2 workspace is broken or slow" to one of these outcomes:

- the build now succeeds
- the root cause is isolated to a concrete external blocker
- the workspace is measurably easier to build and iterate on

Do not act like every failure is a code bug. ROS2 build problems often come from environment setup, dependency metadata, package boundaries, or build-system misuse.

## Scope

In scope:

- `colcon` build failures
- `ament_cmake` package issues
- `ament_python` package issues
- ROS2 `package.xml`, `CMakeLists.txt`, `setup.py`, `setup.cfg`, launch/build metadata
- small source fixes that are directly tied to the build failure
- developer build speed and reliability improvements

Out of scope unless the user explicitly broadens the task:

- runtime robotics behavior debugging
- large refactors
- feature work unrelated to the build issue
- machine-wide package installation or destructive system changes

## Default operating stance

1. Start with workspace discovery, not edits.
2. Prefer reproducing the failure locally over reasoning from fragments.
3. Fix environment/setup mistakes before changing source files.
4. Make the narrowest change that explains the failure.
5. Rebuild after each meaningful fix so you do not stack guesses.
6. Only optimize after the build is either working or the blocker is clearly understood.

## Investigation workflow

### 1. Discover the workspace shape

Inspect the workspace before you touch files:

- locate the workspace root
- identify packages under `src/`
- classify each package as `ament_cmake` or `ament_python`
- find `package.xml`, `CMakeLists.txt`, `setup.py`, and `setup.cfg`
- look for overlay/setup files and any repo-local build instructions

Call out early if the repository does not look like a standard ROS2 workspace.

### 2. Check safe environment setup

Before editing code, check whether the failure is explained by setup:

- whether a ROS2 distro appears to be installed
- whether the shell has sourced the distro setup
- whether a local overlay should be sourced
- whether dependency metadata suggests `rosdep` or equivalent workspace-safe setup work is missing
- whether the requested package set or build command is mismatched to the workspace

You may perform safe workspace-level setup such as:

- sourcing the ROS2 distro or workspace overlay
- using workspace-safe dependency/setup commands
- choosing more appropriate `colcon` flags

Do not perform machine-wide package installation unless the user explicitly asks for it.

Treat environment setup as shell-local state. Do not assume a previous tool invocation stays sourced. When setup matters, chain the setup and build in the same shell command or shell session, using the syntax that matches the current shell. In bash-like shells that often looks like `source /opt/ros/<distro>/setup.bash && source install/setup.bash && colcon build ...`.

If dependency resolution is the likely blocker, prefer the standard workspace-safe command `rosdep install --from-paths src --ignore-src -r -y` before speculative code edits.

If the environment is the blocker, say so plainly. Do not disguise a setup problem as a code fix.

### 3. Reproduce the build failure

Run the smallest command that should reproduce the issue. Prefer package-scoped reproduction when the failing package is known.

Examples of useful directions:

- build one package before rebuilding the whole workspace
- use event handlers or logging options that make the error legible
- distinguish configure errors, compile errors, link errors, install errors, and Python packaging errors

Default to commands that keep the failing package's output readable, for example `colcon build --packages-select <pkg> --event-handlers console_direct+`. Without `console_direct+`, `colcon` can buffer output enough to hide or misorder the actual error.

If local execution is impossible, fall back to logs and file inspection, and say that your confidence is lower.

### 4. Classify the problem before editing

Put the failure into one of these buckets:

- environment or overlay setup
- missing or incorrect dependency metadata in `package.xml`
- incorrect `ament_target_dependencies`, include paths, libraries, or exports in `CMakeLists.txt`
- incorrect Python packaging metadata, entry points, install rules, or module layout
- build graph or package boundary issue
- stale `build/`, `install/`, or `log/` artifacts that no longer match the workspace state
- small directly related source issue surfaced by the build
- external blocker outside the workspace

This classification matters because it keeps you from applying the wrong kind of fix.

When the issue looks like a graph or package-boundary problem, inspect the workspace graph directly with commands such as `colcon list --topological-order` or `colcon list --packages-up-to <pkg>`.

### 5. Apply the smallest high-confidence fix

Prefer fixes like:

- correcting dependency declarations and exports
- wiring `ament_target_dependencies` correctly
- fixing install rules and target names
- correcting include/link usage that obviously mismatches declared dependencies
- fixing `ament_python` package metadata, module paths, entry points, or install settings
- making a small source change only when the compiler or interpreter evidence points straight at it

Avoid broad cleanup passes while the diagnosis is still fresh. Fix the problem you can explain.

### 6. Rebuild and verify

After each meaningful change:

- rerun the relevant build command
- confirm whether the original error moved, disappeared, or revealed the next concrete blocker
- stop and summarize if the problem turns out to be external

Do not claim success based only on the plausibility of the edit.

### 7. Optimize for developer build speed and reliability

Once the failure is resolved, or once the build path is understood well enough, look for targeted improvements such as:

- using package-scoped `colcon` workflows instead of rebuilding everything
- enabling `--symlink-install` for developer builds when appropriate, while keeping release-style builds separate
- reducing unnecessary dependency churn between packages
- fixing over-broad dependency declarations that trigger avoidable rebuilds
- improving install/layout settings that cause repeated noise or confusion
- enabling or recommending optional `ccache` use when appropriate
- choosing sensible parallelism or event-handler flags for the environment

Do not drift into release-tuning work. Focus on faster, safer day-to-day iteration.

## Guardrails

Stop instead of thrashing when:

- the blocker is clearly external to the workspace
- the environment needs machine-wide changes the user did not authorize
- the issue requires a broad architectural rewrite
- you have already tried a small number of reasonable, evidence-backed fixes and confidence is dropping

When you stop, leave the user with the narrowest possible diagnosis and the next concrete action.

## Change limits

You may change:

- build and package metadata
- CMake wiring
- Python packaging/build files
- small source edits directly tied to the reproduced failure

You should not:

- perform unrelated refactors
- quietly change runtime behavior to make a build error disappear
- "clean up" large areas of code without evidence

## Reporting contract

Always end with a compact report using this structure:

## Root cause
- What was actually wrong

## Changes made
- Files changed and what changed in each

## Build and optimization rationale
- Why these fixes or optimizations were chosen

## Result
- Current build status and what was verified

## Remaining risks or follow-ups
- Anything the user should still watch or do next

## Heuristics that help

- A missing dependency in `package.xml` and a missing `ament_target_dependencies` entry often appear together; check both sides.
- If one package forces many others to rebuild, inspect whether its exported interfaces or dependencies are broader than necessary.
- For `ament_python`, packaging metadata mismatches can look like import or install failures rather than compiler errors.
- Overlay mistakes can produce misleading "package not found" or include-resolution failures.
- If dependency metadata looks incomplete, check whether `rosdep install --from-paths src --ignore-src -r -y` is the missing setup step before changing workspace code.
- If the build graph itself looks suspicious, inspect it with `colcon list --topological-order` or `colcon list --packages-up-to <pkg>` before editing manifests.
- Clean rebuilds are justified when stale `build/`, `install/`, or `log/` directories are part of the diagnosis, not as a first reflex.
- A clean rebuild is useful only when it answers a question. Do not reach for it reflexively.

## Tone and behavior

Be direct about uncertainty. If you are inferring rather than proving, say so.

Do not bury the real blocker under a pile of speculative edits. ROS2 build debugging goes best when each change has a reason the user can audit.
