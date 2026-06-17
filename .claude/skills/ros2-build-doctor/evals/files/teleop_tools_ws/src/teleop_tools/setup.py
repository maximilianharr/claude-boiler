from setuptools import setup

package_name = "teleop_tools"

setup(
    name=package_name,
    version="0.1.0",
    packages=[package_name],
    data_files=[
        ("share/ament_index/resource_index/packages", ["resource/" + package_name]),
        ("share/" + package_name, ["package.xml"]),
    ],
    install_requires=["setuptools"],
    zip_safe=True,
    maintainer="Tools Team",
    maintainer_email="dev@example.com",
    description="Console helpers for teleop workflows.",
    license="Apache-2.0",
    entry_points={
        "console_scripts": [
            "teleop-keyboard = teleop_tools.keyboard:main",
        ],
    },
)
