#!/usr/bin/env bash
set -e

echo "=== Base tools ==="
dnf install -y \
  python3 \
  curl \
  wget \
  git \
  vim \
  jq \
  tar \
  unzip

echo "=== SSM Agent ==="
dnf install -y \
  https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_arm64/amazon-ssm-agent.rpm

systemctl enable --now amazon-ssm-agent
