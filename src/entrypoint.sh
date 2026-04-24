#!/bin/bash
set -e

source /opt/ros/humble/setup.bash
source ~/catkin_ws/install/setup.bash
source /usr/share/gazebo/setup.sh

export ROS_DOMAIN_ID=67

export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export RMW_FASTRTPS_USE_SHM=0
export FASTRTPS_DEFAULT_PROFILES_FILE=/dev/null
export QT_QPA_PLATFORM=xcb
export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:~/catkin_ws/install/limo_car/share
export GAZEBO_RESOURCE_PATH=$GAZEBO_RESOURCE_PATH:~/catkin_ws/install/limo_car/share

exec "$@"
