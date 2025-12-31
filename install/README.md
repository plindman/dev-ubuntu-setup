# Installation Scripts

This directory contains all installation scripts organized by category.

## Structure

- `installers/` - All individual installation scripts (prefixed by category)
- `system.sh` - Orchestrator for system utilities
- `dev-tools.sh` - Orchestrator for CLI development tools
- `desktop.sh` - Desktop environment components
- `apps.sh` - GUI applications
- `verify.sh` - Verification functions for apps
- `install_app.sh` - Shared installation helper for apps

## Category Orchestrators

### System (`system.sh`)

Installs core operating system utilities and essential command-line tools that form the foundation of the workstation.

Corresponds to the **System** category in `SOFTWARE_INDEX.md`.

**Scripts:**
- `system-core.sh` - Core system utilities and updates
- `system-networking-tools.sh` - curl, wget
- `system-zsh.sh` - zsh and Oh My Zsh
- `system-services.sh` - openssh-server
- `system-system-tools.sh` - htop, keychain
- `system-editors.sh` - nano, micro, neovim
- `system-dev-fonts.sh` - Nerd Fonts (FiraCode, JetBrainsMono)
- `system-tmux.sh` - tmux and Oh My Tmux
- `system-writing-fonts.sh` - Professional Writing Fonts (Inter, Garamond, etc.)

### Development Tools (`dev-tools.sh`)

Installs command-line tools and utilities for software development.

Corresponds to the **Development Tools (CLI)** category in `SOFTWARE_INDEX.md`.

**Scripts:**
- `dev-tools-tools.sh` - build-essential, ripgrep
- `dev-tools-git.sh` - git-all, gh
- `dev-tools-nodejs.sh` - Node.js
- `dev-tools-bun.sh` - Bun runtime
- `dev-tools-uv.sh` - uv Python package manager
- `dev-tools-gemini-cli.sh` - Gemini CLI
- `dev-tools-claude-code.sh` - Claude Code
- `dev-tools-services.sh` - Docker Engine & CLI

### Desktop (`desktop.sh`)

Installs packages and configurations for graphical desktop environments.

Corresponds to the **Desktop** category in `SOFTWARE_INDEX.md`.

**Components:**
- Core desktop components (gnome-tweaks, gnome-shell-extension-manager, gnome-keyring)
- Desktop utilities (nemo, synaptic)

**Note:** This category should only be installed on a workstation with a display.

### Applications (`apps.sh`)

Installs user-facing graphical applications.

Corresponds to the **Applications (GUI)** category in `SOFTWARE_INDEX.md`.

**Web Browsers:**
- `apps-chrome.sh` - Google Chrome
- `apps-brave-browser.sh` - Brave Browser
- `apps-vivaldi.sh` - Vivaldi Browser

**Development Applications:**
- `apps-vscode.sh` - Visual Studio Code
- `apps-ghostty.sh` - Ghostty Terminal
- `apps-antigravity.sh` - Google Antigravity (AI-first IDE)

**Note:** This category should only be installed on a workstation with a display.

## Helper Scripts

### `verify.sh`

Verification functions for GUI applications. Each app script uses these functions to:
- Check if already installed before attempting installation
- Verify installation success after installation

Can also be run standalone to check installation status.

### `install_app.sh`

Shared installation helper for GUI applications. Handles:
- Idempotency (skip if already installed)
- Verification after installation
- Consistent success/error messaging

App scripts define only:
- `APP_NAME` - Human-readable name
- `APP_VERIFY_FUNC` - Verification function to use
- `install_<app>()` - Function with actual installation commands

## Naming Convention

Installer scripts use the prefix convention:
- `system-*` - System utilities
- `dev-tools-*` - CLI development tools
- `apps-*` - GUI applications

This makes it easy to identify the category of each script in the `installers/` directory.
