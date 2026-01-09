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
print_step "Ensuring base test image is ready..."
docker build -t dev-setup-test-base -f tests/Dockerfile.test-base .

# 2. Run the test
# Create a local logs directory and ensure it is writable
mkdir -p tests/logs
chmod 777 tests/logs

print_step "Starting DX test in clean container..."
# We mount tests/logs to the container's log path
docker run --rm \
    -v "$(pwd)/tests/logs:/home/testuser/.local/state/dev-ubuntu-setup" \
    dev-setup-test-base bash -c "
    set -e
    echo '==> [USER] Fetching and running the installer from GitHub...'
    # We run without flags to test the 'Install All' default behavior
    # Verification is now built into this command
    curl -fsSL https://raw.githubusercontent.com/plindman/dev-ubuntu-setup/main/install.sh | bash
"
