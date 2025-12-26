#!/bin/bash

# This script orchestrates the installation of all components in the 'dev-tools' category.

set -e

SCRIPT_DIR=$(dirname "$0")

echo "--- Running Development Tools (CLI) Installation Scripts ---"

# Find and run all .sh files in this directory, except for this one.
for script in "$SCRIPT_DIR"/*.sh; do
    if [ -f "$script" ] && [ "$(basename "$script")" != "install.sh" ]; then
        echo "Executing $(basename "$script")..."
        bash "$script"
    fi
done

echo "--- Development Tools (CLI) Installation Complete ---"