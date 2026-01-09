#!/bin/bash
# Simple DX test: Simulate a new machine by mounting local code into a clean Ubuntu container.

set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Use exactly what a user would type, but pointing to our local volume for the 'repo'
# to test the changes we just made.
docker run --rm \
    -v "$PROJECT_ROOT":/src:ro \
    -e REPO_URL=/src \
    ubuntu:24.04 bash -c "
        echo '==> 1. Initial Prep (User installs curl/sudo)'
        apt-get update -qq && apt-get install -y curl sudo -qq
        
        echo '==> 2. Create testuser'
        useradd -m -s /bin/bash testuser
        echo 'testuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
        
        echo '==> 3. Run Bootstrapper as testuser'
        # We must install git as root FIRST because our test script needs it for safe.directory
        # before the installer even starts.
        apt-get install -y git -qq
        
        sudo -u testuser REPO_URL=/src bash <<EOF
            set -e
            git config --global --add safe.directory /src
            bash /src/install.sh --system
EOF
        
        echo '==> 4. Verify Result as testuser'
        sudo -u testuser bash <<EOF
            set -e
            cd ~/scripts/dev-ubuntu-setup
            ./bin/verify.sh
EOF
    "
