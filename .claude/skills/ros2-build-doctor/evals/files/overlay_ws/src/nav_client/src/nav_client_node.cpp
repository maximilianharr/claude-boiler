#include <my_robot_msgs/msg/route_goal.hpp>
#include <rclcpp/rclcpp.hpp>

class NavClientNode : public rclcpp::Node {
public:
  NavClientNode() : Node("nav_client_node") {}

  void handle_goal(const my_robot_msgs::msg::RouteGoal & goal) {
    last_goal_id_ = goal.goal_id;
  }

private:
  int64_t last_goal_id_{0};
};

int main(int argc, char ** argv) {
  rclcpp::init(argc, argv);
  rclcpp::spin(std::make_shared<NavClientNode>());
  rclcpp::shutdown();
  return 0;
}
