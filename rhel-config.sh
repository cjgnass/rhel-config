#!/bin/bash
set -e  # exit on error

echo "Starting setup..."

# Update system
sudo dnf update -y  # or apt, yum, etc.


# Install packages
sudo dnf install -y \
  curl \
  tmux \
  python3 \
  python3-pip \
  python3-devel \
  gcc \
  gcc-c++ \
  gdb \
  java-21-openjdk-devel

# Neovim
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
yum install -y neovim python3-neovim

# Node.js (via dnf module)
sudo dnf module enable -y nodejs:20
sudo dnf install -y nodejs

# .NET SDK
sudo dnf install -y dotnet-sdk-8.0

# Docker
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"

# uv (Python package manager)
curl -LsSf https://astral.sh/uv/install.sh | sh

git clone https://github.com/cjgnass/nvim-config.git ~/.config/nvim

git clone https://github.com/cjgnass/tmux-config.git && mv tmux-config/.tmux.conf . && rm -rf tmux-config

echo "Done!"
