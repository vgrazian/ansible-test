# Minimal Ansible Lab

A lightweight Ansible testing environment with Podman containers featuring one controller and three nodes with different Linux distributions.

## Features

- **Controller**: Debian-based with Ansible and essential tools
- **Nodes**:
  - Ubuntu 22.04
  - CentOS 9
  - Alpine Linux 3.18
- Minimal automation - just start and stop scripts
- SSH key authentication
- Pre-configured inventory

## Quick Start

1. Build and start the lab:

   ```bash
   ./start.sh
   ```

2. Stop the lab:

   ```bash

./stop.sh

```
