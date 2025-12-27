# Desktop Configuration

This directory contains scripts for installing packages and configurations specific to a graphical desktop environment (GUI). These components should only be installed on a workstation with a display.

This corresponds to the **Desktop** category in the `SOFTWARE_INDEX.md`.

## Installation Script

This directory uses a single, simple `install.sh` script that directly installs all desktop components using apt packages. Given the straightforward nature of these packages (all available via standard apt repositories), a modular script structure was not necessary.

### Components Installed

*   **Core Desktop Components** (`gnome-tweaks`, `gnome-shell-extension-manager`, `gnome-keyring`, `libsecret-tools`)
*   **Desktop Utilities** (`nemo`, `synaptic`)