FROM osrf/ros:humble-desktop-full
ARG USERNAME=ros2user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

RUN apt update -y && apt install -y sudo
RUN echo "$USERNAME ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

RUN apt update && apt upgrade -y

RUN apt update && apt install -y \
    ament-cmake \
    ccls \
    python3-colcon-common-extensions \
    python3-pip \
    vim \
    clang \
    clang-format \
    clang-tidy \
    ros-humble-gazebo* \
    ros-humble-rqt* \
    ros-humble-joint-state-publisher-gui \
    ros-humble-rqt-robot-steering \
    ros-humble-rmw-cyclonedds-cpp \
    ros-humble-cartographer \
    ros-humble-cartographer-ros \
    ros-humble-navigation2 \
    ros-humble-nav2-bringup \
    ros-humble-slam-toolbox
RUN git clone https://github.com/YDLIDAR/YDLidar-SDK.git /tmp/YDLidar-SDK && \
	cd /tmp/YDLidar-SDK && \
	mkdir build && cd build && \
	cmake .. && make && make install && \
	rm -rf /tmp/YDLidar.sdk
RUN echo "source /opt/ros/humble/setup.bash" >> /home/$USERNAME/.bashrc && \
    echo "source /usr/share/gazebo/setup.sh" >> /home/$USERNAME/.bashrc && \
    echo "source ~/catkin_ws/install/setup.bash" >> /home/$USERNAME/.bashrc
RUN echo "source ~/catkin_ws/src/limo_ros2/install/setup.bash" >> /home/$USERNAME/.bashrc

ENV SHELL=/bin/bash
ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

USER $USERNAME
CMD ["/bin/bash"]
