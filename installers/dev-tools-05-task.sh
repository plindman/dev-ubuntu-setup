#!/bin/bash

# Script to install Task (Taskfile).
# Pre-requisites: system-01-networking.sh (for curl).
# https://taskfile.dev/docs/installation

APP_NAME="Task"
APP_COMMAND="task"

install_task() {
    # Install to ~/.local/bin which is in our PATH
    mkdir -p "$HOME/.local/bin"
    sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b "$HOME/.local/bin"
}
