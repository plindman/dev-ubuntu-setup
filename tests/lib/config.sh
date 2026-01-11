#!/bin/bash
# Shared configuration for tests

# Docker Configuration
CONTAINER_IMAGE="dev-ubuntu-setup"
CONTAINER_NAME_BASE="dev-ubuntu-setup" # Suffix can be added by specific tests
CONTAINER_USER="ubuntu"

# Paths inside the container
CONTAINER_HOME="/home/$CONTAINER_USER"
CONTAINER_SRC="$CONTAINER_HOME/dev-ubuntu-setup"
CONTAINER_LOGS="$CONTAINER_HOME/.local/state/dev-ubuntu-setup"
