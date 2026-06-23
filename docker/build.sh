#!/bin/bash
set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Building ROS2 Humble image for RK3568 (ARM64) ==="
docker build -t ros2_rk3568:humble -f "${SCRIPT_DIR}/Dockerfile" "${SCRIPT_DIR}"
echo "=== Done: ros2_rk3568:humble ==="
