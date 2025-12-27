# System Configuration

This directory contains scripts for installing core operating system utilities and essential command-line tools that form the foundation of the workstation.

This corresponds to the **System** category in the `SOFTWARE_INDEX.md`.

## Scripts

This directory contains the following installation scripts:

*   `core.sh`: Installs core system utilities and performs system upgrades.
*   `services.sh`: Installs system services like `openssh-server`.
*   `zsh.sh`: Installs `zsh` and the `Oh My Zsh` framework.
*   `tmux.sh`: Installs `tmux` and the `Oh My Tmux` framework.
*   `fonts.sh`: Installs Nerd Fonts to support icons in the terminal and editor.
*   `editors.sh`: Installs CLI editors: `nano`, `micro`, and `neovim`.
*   `system-tools.sh`: Installs general system tools like `htop` and `keychain`.
*   `networking-tools.sh`: Installs networking tools like `curl` and `wget`.

## Execution Order

The `install.sh` orchestrator runs these scripts in a specific order to handle dependencies correctly:

1.  `core.sh` - Updates system and installs essential packages
2.  `networking-tools.sh` - Installs curl/wget needed for downloads
3.  `zsh.sh` - Installs shell (early because it's a core user tool; needs curl from networking-tools)
4.  `services.sh` - Installs system services
5.  `system-tools.sh` - Installs monitoring tools
6.  `editors.sh` - Installs text editors
7.  `fonts.sh` - Installs fonts (may need networking tools)
8.  `tmux.sh` - Installs terminal multiplexer
