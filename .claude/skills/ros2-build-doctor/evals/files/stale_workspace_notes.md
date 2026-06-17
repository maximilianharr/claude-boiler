# Stale artifact notes

This workspace used to contain a package named `planner_msgs`. It was renamed to `route_msgs` yesterday and the source tree was updated.

- `src/` now contains only `route_msgs`
- some developers still see install or package-conflict errors mentioning `planner_msgs`
- do not assume the source package is wrong just because the old package name appears in the error

If the old package name appears only under `build/`, `install/`, or `log/`, prefer a targeted clean of those stale artifacts over speculative edits to `package.xml` or `CMakeLists.txt`.
