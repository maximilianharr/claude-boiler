cmake_minimum_required(VERSION 3.8)
project(path_server)

find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(mission_msgs REQUIRED)
find_package(nav_msgs REQUIRED)
find_package(sensor_msgs REQUIRED)
find_package(tf2_ros REQUIRED)
find_package(visualization_msgs REQUIRED)

add_executable(path_server_node
  src/path_server.cpp
)

ament_target_dependencies(path_server_node
  rclcpp
  mission_msgs
  nav_msgs
  sensor_msgs
  tf2_ros
  visualization_msgs
)

install(TARGETS path_server_node
  DESTINATION lib/${PROJECT_NAME}
)

ament_package()
