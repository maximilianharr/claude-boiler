#include <mission_msgs/msg/mission_plan.hpp>
#include <rclcpp/rclcpp.hpp>

namespace mission {

class PathServer : public rclcpp::Node {
public:
  PathServer() : Node("path_server") {}

  void publish_plan(const mission_msgs::msg::MissionPlan & plan) {
    last_plan_size_ = plan.waypoints.size();
  }

private:
  std::size_t last_plan_size_{0};
};

}  // namespace mission

int main(int argc, char ** argv) {
  rclcpp::init(argc, argv);
  rclcpp::spin(std::make_shared<mission::PathServer>());
  rclcpp::shutdown();
  return 0;
}
