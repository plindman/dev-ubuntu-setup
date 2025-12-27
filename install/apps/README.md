# Applications (GUI)

This directory contains scripts for installing all user-facing graphical applications, for both general and development purposes.

This corresponds to the **Applications (GUI)** category in the `SOFTWARE_INDEX.md`.

## Installation

This directory uses an `install.sh` orchestrator that runs all application installation scripts in order.

**Important:** These applications should only be installed on a workstation with a graphical display (GUI).

## Scripts

### Web Browsers

*   `chrome.sh` - Installs Google Chrome
*   `brave-browser.sh` - Installs Brave Browser
*   `vivaldi.sh` - Installs Vivaldi Browser

### Development Applications

*   `vscode.sh` - Installs Visual Studio Code
*   `ghostty.sh` - Installs Ghostty Terminal
*   `antigravity.sh` - Installs Google Antigravity (AI-first IDE)

### Verification

*   `verify.sh` - Verification functions for all applications. Source this file to use verification functions in install scripts. Can also be run standalone to check installation status.

## Reference Files

Original reference documentation and commands are stored in `docs/sources/`:
*   `install_chrome` - Reference notes for Chrome installation
*   `install_brave_browser` - Reference script for Brave Browser
*   `install_vivaldi` - Reference commands for Vivaldi
*   `install_vscode` - Reference notes for VS Code
*   `install_ghostty` - Reference one-liner for Ghostty
*   `install_google_antigravity` - Reference script for Antigravity

## Execution Order

The `install.sh` orchestrator runs scripts in the following order:
1.  Chrome
2.  Brave Browser
3.  Vivaldi
4.  VS Code
5.  Ghostty
6.  Antigravity