#!/bin/bash
# Internal command: test-fonts
# Focused test for Font Installers only

set -e
cd "$CONTAINER_SRC"

# Source the library (loads output, utils, apt, fonts)
source install/lib/module_runner.sh

# Ensure dependencies (core + networking) via proper modules
quiet_apt_update
source install/installers/system-01-core.sh
install_core
source install/installers/system-02-networking-tools.sh
install_networking_tools

echo ''
print_header 'Testing Console Fonts...'
# Corrected filename from system-02 to system-03
source install/installers/system-03-console-fonts.sh
install_fonts

echo ''
print_header 'Testing Writing Fonts...'
source install/installers/writing-01-fonts.sh
install_writing_fonts
