# Ansible Test Lab

A lightweight Ansible testing environment with Podman containers featuring one controller and three nodes with different Linux distributions.

**Repository**: <https://github.com/vgrazian/ansible-test.git>

## Features

- **Controller**: Debian-based with Ansible and essential tools
- **Nodes**:
  - Ubuntu 22.04
  - CentOS 9
  - Alpine Linux 3.18
- Minimal automation - just start and stop scripts
- SSH key authentication
- Pre-configured inventory
- Security-focused with proper .gitignore

## Security Notes

- SSH keys are automatically generated and ignored by git
- Sensitive files are excluded via .gitignore
- No hardcoded passwords in version control
- Isolated container network

## Quick Start

1. Clone the repository:

   ```bash
   git clone https://github.com/vgrazian/ansible-test.git
   cd ansible-test
   ```

2. Build and start the lab:

   ```bash
   ./start.sh
   ```

3. Stop the lab:

   ```bash
   ./stop.sh
   ```

## Usage

Once started, you'll be in the controller container with access to:

- Three target nodes: `ubuntu_node`, `centos_node`, `alpine_node`
- Pre-configured SSH keys
- Example playbooks in `/ansible/playbooks/`

### Basic Testing

```bash
# Test connectivity
ansible-playbook playbooks/ping.yml

# Get host information
ansible-playbook playbooks/test.yml

# Run ad-hoc commands
ansible all -m ping
ansible all -a "hostname"
ansible all -a "cat /etc/os-release"
```

## Manual Steps

The lab is designed to be minimal. You can:

1. Add your own playbooks to `ansible/playbooks/`
2. Modify the inventory in `ansible/inventory`
3. Extend container configurations as needed

## Requirements

- Podman
- macOS/Linux (tested on macOS with Podman machine)

## File Structure

```
ansible-test/
├── .gitignore          # Security: excludes keys and sensitive files
├── README.md
├── start.sh           # Start the lab
├── stop.sh            # Stop the lab
├── ansible/           # Ansible configuration
│   ├── ansible.cfg
│   ├── inventory
│   └── playbooks/
├── Containerfiles/    # Container definitions
│   ├── controller/
│   ├── ubuntu-node/
│   ├── centos-node/
│   └── alpine-node/
└── keys/              # SSH keys (auto-generated, gitignored)
    └── .gitkeep       # Keeps directory in git
```

## Development

To contribute to this project:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request
