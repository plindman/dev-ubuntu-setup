#!/bin/bash
# Test Font Installers

set -e
cd "$CONTAINER_SRC"

# Source the library (loads output, utils, apt, fonts)
source lib/module_runner.sh

# Setup Logging
setup_logging "test-fonts"

# Ensure dependencies (core + networking) via proper modules
quiet_apt_update
source installers/system-00-core.sh
install_core
source installers/system-01-networking.sh
install_networking_tools

echo ''
print_header 'Testing Console Fonts...'
source installers/system-03-console-fonts.sh
install_fonts

echo ''
print_header 'Testing Writing Fonts...'
source installers/writing-01-fonts.sh
install_writing_fonts

echo '==> [Container] Font test completed successfully!'
