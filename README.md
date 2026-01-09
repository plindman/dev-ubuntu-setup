# Development Workstation Setup for Ubuntu

This repository contains scripts and configurations for setting up a development workstation on Ubuntu. The goal is to automate the installation of essential tools and applications, making it easy to set up a new machine or replicate an existing environment.

## Getting Started

You have two options for getting started:

### Quick Install (Convenient)

This method allows for a quick setup using a single command. Use this if you trust the repository's contents and prioritize speed.

```bash
# This command will download and execute the install.sh script directly.
# Ensure you understand what the script does before running.
curl -fsSL https://raw.githubusercontent.com/plindman/dev-ubuntu-setup/main/install.sh | bash
```

### Manual Install (Recommended for Transparency and Control)

This method provides more transparency and control, allowing you to review the scripts before execution and customize the installation process.

```bash
git clone https://github.com/plindman/dev-ubuntu-setup.git
cd dev-ubuntu-setup
./install.sh
```

The `install.sh` script will guide you through the installation process. You can choose to install everything at once or select specific categories of tools.

## Repository Structure

The repository is organized into several key parts:

*   `install/`: Contains all the installation scripts, categorized into subdirectories:
    *   `system/`: For core system utilities and essential admin tools.
    *   `dev-tools/`: For command-line development tools (including Docker).
    *   `desktop/`: For foundational GUI and desktop environment settings.
    *   `apps/`: For all user-facing GUI applications (e.g., browsers, code editors).
*   `dotfiles/`: Contains personal configuration files (e.g., `.zshrc`, `.gitconfig`) that will be symlinked into your home directory.
*   `install.sh`: The main script that orchestrates the entire setup process.
*   `SOFTWARE_INDEX.md`: A comprehensive index of all software components managed by this repository.

## Dotfiles & XDG Compliance

This repository adheres to the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html) for managing dotfiles. This means:

*   Configuration files are stored in `~/.config/` (e.g., `~/.config/nvim` instead of `~/.nvim`).
*   Data files are stored in `~/.local/share/`.
*   Cache files are stored in `~/.cache/`.
*   Custom executables (scripts, binaries) are placed in `~/.local/bin/` to keep them separate from system-wide binaries.

This approach ensures a clean and organized home directory, preventing clutter by moving configuration files out of the root of `$HOME`. Dotfiles in this repository's `dotfiles/` directory will reflect these conventions and be symlinked accordingly.

## Customization

You can customize the installation by editing the `install.sh` script or by running it with specific flags (we can define these later). To add a new installation script, simply create a new shell script in the appropriate directory and add a call to it in the `install.sh` script.

## A Note on Script Execution

All installation scripts in this repository are written and tested to be run with `bash`. While the setup will install and configure `zsh` as the default interactive shell for the user, the provisioning scripts themselves should always be executed with `bash` to ensure maximum portability and avoid issues with a partially configured `zsh` environment during setup.