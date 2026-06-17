# Developer build notes

The team usually runs `colcon build` from the workspace root after every change.

Most day-to-day edits land in `path_server` or `mission_console`. We almost never need a full rebuild, but people still do it because the current workflow is not documented well and nobody has revisited the developer build setup in a while.
