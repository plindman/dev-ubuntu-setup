#!/bin/bash
# Focused test for Font Installers only

set -e

# Initialize Test Environment
source "$(cd "$(dirname "${BASH_SOURCE[0]}")"; while [ ! -f lib/config.sh ] && [ "$PWD" != "/" ]; do cd ..; done; pwd)/lib/config.sh"
prepare_test_env

# 4. Run Test
echo "==> Starting Font test..."

CMD_STRING=$(get_test_command "test_fonts")

run_test_container "$CMD_STRING"