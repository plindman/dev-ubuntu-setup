#!/bin/bash
# Test the full "New Machine" Developer Experience (DX) by fetching from GitHub.
# Uses a cached base image for speed.

set -e

# Colors
BLUE='\033[0;34m'
NC='\033[0m'

print_step() {
    echo -e "${BLUE}==>${NC} \033[1m${1}\033[0m"
}

# 1. Build/Use cached base image
print_step "Building base image aligned to your user ID ($(id -u))..."
docker build \
    --build-arg USER_ID=$(id -u) \
    --build-arg GROUP_ID=$(id -g) \
    -t dev-ubuntu-setup -f tests/Dockerfile .

# 2. Run the test
# Create a local logs directory
mkdir -p tests/logs

print_step "Starting DX test in clean container..."
docker run --rm \
    -v "$(pwd)/tests/logs:/home/ubuntu/.local/state/dev-ubuntu-setup" \
    dev-ubuntu-setup bash -c "
    set -e
    echo '==> I am: \$(whoami) (ID: \$(id -u))'
    echo '==> Fetching and running the installer...'
    curl -fsSL https://raw.githubusercontent.com/plindman/dev-ubuntu-setup/main/install.sh | bash
"
print_step "DX test completed. Check logs in tests/logs/ for details."