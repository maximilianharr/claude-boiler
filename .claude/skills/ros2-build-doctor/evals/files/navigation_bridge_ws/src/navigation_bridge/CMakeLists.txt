cmake_minimum_required(VERSION 3.8)
project(navigation_bridge)

find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(nav_msgs REQUIRED)

add_executable(navigation_bridge_node
  src/navigation_bridge_node.cpp
)

target_include_directories(navigation_bridge_node PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
  $<INSTALL_INTERFACE:include>
)

ament_target_dependencies(navigation_bridge_node
  rclcpp
  nav_msgs
)

install(TARGETS navigation_bridge_node
  DESTINATION lib/${PROJECT_NAME}
)

ament_package()
