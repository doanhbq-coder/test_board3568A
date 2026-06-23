#!/bin/bash
set -e

echo "=== Cài đặt Docker trên Armbian (RK3568) ==="

# Gỡ Docker cũ nếu có
sudo apt-get remove -y docker docker-engine docker.io containerd runc 2>/dev/null || true

# Cài dependencies
sudo apt-get update
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Thêm Docker GPG key
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Xác định distro gốc (Armbian dựa trên Debian hoặc Ubuntu)
if [ -f /etc/os-release ]; then
    . /etc/os-release
    # Armbian thường set ID_LIKE=debian hoặc ubuntu
    if echo "$ID_LIKE" | grep -qi ubuntu || [ "$ID" = "ubuntu" ]; then
        REPO_URL="https://download.docker.com/linux/ubuntu"
        CODENAME=$(. /etc/os-release && echo "$UBUNTU_CODENAME")
        # Fallback nếu không có UBUNTU_CODENAME
        [ -z "$CODENAME" ] && CODENAME="jammy"
    else
        REPO_URL="https://download.docker.com/linux/debian"
        CODENAME=$(. /etc/os-release && echo "$VERSION_CODENAME")
        [ -z "$CODENAME" ] && CODENAME="bookworm"
    fi
else
    REPO_URL="https://download.docker.com/linux/debian"
    CODENAME="bookworm"
fi

echo "Repo: ${REPO_URL} (${CODENAME})"

# Thêm Docker repo
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] ${REPO_URL} ${CODENAME} stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Cài Docker
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Thêm user hiện tại vào group docker
sudo usermod -aG docker "$USER"

# Bật Docker service
sudo systemctl enable docker
sudo systemctl start docker

echo ""
echo "=== Docker đã cài xong ==="
echo "Version: $(docker --version)"
echo ""
echo "QUAN TRỌNG: Logout rồi login lại để dùng docker không cần sudo."
echo "Hoặc chạy: newgrp docker"
