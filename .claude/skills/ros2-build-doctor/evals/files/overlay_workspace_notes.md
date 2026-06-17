# Overlay workspace notes

`nav_client` depends on custom messages from a sibling interfaces workspace that was already built earlier today.

- interfaces workspace install prefix: `/home/dev/ws/robot_interfaces/install`
- normal happy-path shell setup:
  - `source /opt/ros/humble/setup.bash`
  - `source /home/dev/ws/robot_interfaces/install/setup.bash`
  - then build or test the downstream workspace

No package metadata changes are expected for this scenario. If `find_package(my_robot_msgs)` fails after opening a fresh shell, assume the environment changed before assuming the workspace files are wrong.
