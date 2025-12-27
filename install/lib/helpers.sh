#!/bin/bash
#
# Main helper functions library.
# Sources all modular helper files.

# Get the directory where this script is located
HELPER_LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source all helper modules
source "$HELPER_LIB_DIR/output.sh"
source "$HELPER_LIB_DIR/utils.sh"
source "$HELPER_LIB_DIR/package.sh"
source "$HELPER_LIB_DIR/execution.sh"
