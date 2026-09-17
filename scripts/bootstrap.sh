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

echo "=== GNOME Desktop ==="
dnf groupinstall -y "Server with GUI"

systemctl set-default graphical.target

echo "=== Disable Wayland for DCV ==="
sed -i \
  's/^#WaylandEnable=false/WaylandEnable=false/' \
  /etc/gdm/custom.conf

systemctl enable gdm
systemctl restart gdm

echo "=== Amazon DCV ==="
cd /tmp

rpm --import \
  https://d1uj6qtbmh3dt5.cloudfront.net/NICE-GPG-KEY

wget -q \
  https://d1uj6qtbmh3dt5.cloudfront.net/2025.0/Servers/nice-dcv-2025.0-20103-el9-aarch64.tgz

tar -xzf \
  nice-dcv-2025.0-20103-el9-aarch64.tgz

DCV_DIR=$(find /tmp -maxdepth 1 -type d -name 'nice-dcv-*' | head -n 1)
cd "$DCV_DIR"

dnf install -y \
  ./nice-dcv-server-*.aarch64.rpm \
  ./nice-dcv-web-viewer-*.aarch64.rpm

systemctl enable --now dcvserver

echo "=== Desktop user ==="
id dcv-user >/dev/null 2>&1 || useradd -m dcv-user

echo "=== DCV Session ==="
dcv create-session \
  --type=console \
  --owner dcv-user \
  --name "RHEL DevOps Desktop" \
  rhel-desktop || true

echo "=== Bootstrap complete ==="
