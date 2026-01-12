# Installation Scripts

This directory contains all installation scripts and libraries.

## Structure

- `installers/` - Individual installation scripts categorized by number and type.
- `lib/` - Shared shell libraries for APT, fonts, modules, and output.

## Shared Libraries (`lib/`)

- `apt.sh`: Utilities for APT package management and version reporting.
- `fonts.sh`: Utilities for manual font installation (ZIP) and version extraction (fc-list).
- `module_runner.sh`: Core logic for executing installation modules.
- `output.sh`: Formatting and color utilities for terminal output.
- `utils.sh`: General helper functions.

## Installer Modules (`installers/`)

Scripts are named using the convention `<category>-<number>-<name>.sh`.

### System (`system-*.sh`)
Core foundational utilities.
- `system-01-core.sh`: Essential packages (unzip, fontconfig).
- `system-02-networking-tools.sh`: curl, wget.
- `system-03-console-fonts.sh`: Nerd Fonts (FiraCode, JetBrainsMono) for terminal/editors.
- `system-04-zsh.sh`: zsh and Oh My Zsh.
- `system-05-tmux.sh`: tmux and Oh My Tmux.
- `system-06-services.sh`: openssh-server.
- `system-07-system-tools.sh`: htop, keychain.
- `system-08-editors.sh`: nano, micro, neovim.

### Development Tools (`dev-tools-*.sh`)
CLI tools for software development.
- `dev-tools-01-tools.sh`: build-essential, ripgrep.
- `dev-tools-05-task.sh`: Task runner.
- `dev-tools-10-nodejs.sh`: Node.js and npm.

### Applications (`apps-*.sh`)
User-facing GUI applications.
- `apps-01-chrome.sh`: Google Chrome.
- `apps-04-vscode.sh`: VS Code.
- `apps-05-ghostty.sh`: Ghostty Terminal.
- `apps-09-texstudio.sh`: TeXstudio IDE.

## Development & Testing
Refer to [tests/README.md](../tests/README.md) for details on how to test these scripts.