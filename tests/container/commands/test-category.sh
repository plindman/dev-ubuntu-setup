#!/bin/bash
# Internal command: test-category (Template)

CATEGORY="{{CATEGORY}}"

set -e
# Navigate to the project root inside container
cd "$CONTAINER_SRC"

echo '==> [Container] Loading Library...'
source install/lib/module_runner.sh

# Setup Logging
setup_logging "test-category-$CATEGORY"

echo '==> [Container] Installing System Layer...'
quiet_apt_update
install_category "system"

if [ "$CATEGORY" != "system" ]; then
    echo "==> [Container] Installing Category: $CATEGORY"
    install_category "$CATEGORY"
fi

echo "==> [Container] Verifying Category: $CATEGORY"
verify_category "$CATEGORY"

echo '==> [Container] Test Complete.'