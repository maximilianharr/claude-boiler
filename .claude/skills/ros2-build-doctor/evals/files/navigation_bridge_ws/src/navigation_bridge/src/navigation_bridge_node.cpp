#include <geometry_msgs/msg/pose_stamped.hpp>
#include <nav_msgs/msg/path.hpp>
#include <rclcpp/rclcpp.hpp>

class NavigationBridgeNode : public rclcpp::Node {
public:
  NavigationBridgeNode() : Node("navigation_bridge_node") {
    publisher_ = create_publisher<geometry_msgs::msg::PoseStamped>("goal_pose", 10);
    subscription_ = create_subscription<nav_msgs::msg::Path>(
      "planner_path", 10, [this](const nav_msgs::msg::Path::SharedPtr msg) {
        if (!msg->poses.empty()) {
          publisher_->publish(msg->poses.front());
        }
      });
  }

private:
  rclcpp::Publisher<geometry_msgs::msg::PoseStamped>::SharedPtr publisher_;
  rclcpp::Subscription<nav_msgs::msg::Path>::SharedPtr subscription_;
};

int main(int argc, char ** argv) {
  rclcpp::init(argc, argv);
  rclcpp::spin(std::make_shared<NavigationBridgeNode>());
  rclcpp::shutdown();
  return 0;
}
