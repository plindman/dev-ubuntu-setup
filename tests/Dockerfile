FROM ubuntu:24.04

# Avoid prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install basic requirements for the bootstrapper and sudo
RUN apt-get update && apt-get install -y \
    curl \
    git \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Setup a test user to simulate a real environment
RUN useradd -m -s /bin/bash testuser && \
    echo "testuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER testuser
WORKDIR /home/testuser

# Copy the current codebase into the container
# This allows testing local changes without committing/pushing
COPY --chown=testuser:testuser . /home/testuser/scripts/dev-ubuntu-setup

WORKDIR /home/testuser/scripts/dev-ubuntu-setup

# Default command is just to keep it alive or we can set it to the test script
CMD ["/bin/bash"]
