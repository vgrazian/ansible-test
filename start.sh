#!/usr/bin/env bash

set -eu

LAB_DIR=$(realpath "$(dirname "$0")")
cd "$LAB_DIR"

echo "Building Ansible lab containers..."

# Generate SSH keys if they don't exist
if [ ! -f "keys/id_rsa" ]; then
    echo "Generating SSH keys..."
    ssh-keygen -t rsa -N "" -f keys/id_rsa
fi

# Build container images
echo "Building controller image..."
podman build -t ansible_controller ./Containerfiles/controller

echo "Building node images..."
podman build -t ubuntu_node ./Containerfiles/ubuntu-node
podman build -t centos_node ./Containerfiles/centos-node
podman build -t alpine_node ./Containerfiles/alpine-node

# Create network
echo "Creating lab network..."
podman network create lab_network 2>/dev/null || true

# Start nodes and setup SSH
echo "Starting nodes..."
for node_type in ubuntu centos alpine; do
    node_name="${node_type}_node"
    echo "Starting $node_name..."
    podman run -d --name $node_name --network lab_network ${node_type}_node
    
    # Setup SSH keys
    podman exec $node_name mkdir -p /root/.ssh
    podman cp keys/id_rsa.pub $node_name:/tmp/key.pub
    podman exec $node_name sh -c "cat /tmp/key.pub >> /root/.ssh/authorized_keys && chmod 600 /root/.ssh/authorized_keys"
    podman exec $node_name rm -f /tmp/key.pub
done

# Wait for nodes to be ready
echo "Waiting for nodes to start..."
sleep 10

# Start controller with SSH keys mounted
echo "Starting controller..."
podman run -it --name ansible_controller \
    --network lab_network \
    -v "${LAB_DIR}/keys/id_rsa:/root/.ssh/id_rsa:Z" \
    -v "${LAB_DIR}/keys/id_rsa.pub:/root/.ssh/id_rsa.pub:Z" \
    -v "${LAB_DIR}/ansible:/ansible:Z" \
    ansible_controller