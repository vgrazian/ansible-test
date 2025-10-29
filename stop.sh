#!/usr/bin/env bash

set -eu

LAB_DIR=$(realpath "$(dirname "$0")")
cd "$LAB_DIR"

echo "Stopping Ansible lab..."

# Remove containers
podman rm -f ansible_controller 2>/dev/null || true
podman rm -f ubuntu_node 2>/dev/null || true
podman rm -f centos_node 2>/dev/null || true
podman rm -f alpine_node 2>/dev/null || true
podman rm -f rhel_node 2>/dev/null || true

# Remove network
podman network rm lab_network 2>/dev/null || true

echo "Lab stopped."