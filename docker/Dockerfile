# ROS2 Humble cho Rockchip RK3568 (ARM64 / Armbian)
ARG ROS_DISTRO=humble
FROM ros:${ROS_DISTRO}-ros-base

ENV DEBIAN_FRONTEND=noninteractive \
    ROS_DISTRO=${ROS_DISTRO} \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PYTHONUNBUFFERED=1

# ── System tools ─────────────────────────────────────────────────────
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip \
    python3-colcon-common-extensions \
    python3-rosdep \
    usbutils \
    i2c-tools \
    can-utils \
    iproute2 \
    iputils-ping \
    net-tools \
    curl \
    vim-tiny \
    && rm -rf /var/lib/apt/lists/*

# ── ROS2 packages ───────────────────────────────────────────────────
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-${ROS_DISTRO}-demo-nodes-cpp \
    ros-${ROS_DISTRO}-demo-nodes-py \
    ros-${ROS_DISTRO}-tf2-ros \
    ros-${ROS_DISTRO}-teleop-twist-keyboard \
    ros-${ROS_DISTRO}-rplidar-ros \
    ros-${ROS_DISTRO}-micro-ros-agent \
    ros-${ROS_DISTRO}-navigation2 \
    ros-${ROS_DISTRO}-nav2-bringup \
    ros-${ROS_DISTRO}-slam-toolbox \
    ros-${ROS_DISTRO}-robot-localization \
    ros-${ROS_DISTRO}-xacro \
    ros-${ROS_DISTRO}-robot-state-publisher \
    ros-${ROS_DISTRO}-joint-state-publisher \
    ros-${ROS_DISTRO}-rosbridge-server \
    ros-${ROS_DISTRO}-diagnostic-updater \
    && rm -rf /var/lib/apt/lists/*

# ── Python libs ──────────────────────────────────────────────────────
RUN pip3 install --no-cache-dir \
    pyserial \
    numpy

# ── Workspace ────────────────────────────────────────────────────────
RUN mkdir -p /ros2_ws/src
WORKDIR /ros2_ws

COPY entrypoint.sh /ros_entrypoint.sh
RUN chmod +x /ros_entrypoint.sh

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
