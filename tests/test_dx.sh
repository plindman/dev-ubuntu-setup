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
# We use -i to keep it interactive so we see output in real-time
print_step "Starting DX test in clean container..."
docker run --rm dev-setup-test-base bash -c "
    set -e
    echo '==> [USER] Installing curl...'
    sudo apt-get update -qq && sudo apt-get install -y curl -qq
    
    echo '==> [USER] Fetching and running the installer from GitHub...'
    curl -fsSL https://raw.githubusercontent.com/plindman/dev-ubuntu-setup/main/install.sh | bash -s -- --all
    
    echo '==> [USER] Verifying final state...'
    cd ~/scripts/dev-ubuntu-setup
    ./bin/verify.sh
"