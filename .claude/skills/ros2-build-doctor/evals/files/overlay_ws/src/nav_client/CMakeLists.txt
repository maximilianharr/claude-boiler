cmake_minimum_required(VERSION 3.8)
project(nav_client)

find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(my_robot_msgs REQUIRED)

add_executable(nav_client_node
  src/nav_client_node.cpp
)

ament_target_dependencies(nav_client_node
  rclcpp
  my_robot_msgs
)

install(TARGETS nav_client_node
  DESTINATION lib/${PROJECT_NAME}
)

ament_package()
