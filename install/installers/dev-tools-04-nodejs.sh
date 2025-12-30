#!/bin/bash

# Script to install Node.js.
# This corresponds to the "Development Tools (CLI)" -> "Runtimes & Package Managers" category in SOFTWARE_INDEX.md.

APP_NAME="NVM and Node.js"
APP_COMMAND="node"

install_nodejs() {
    # Install Node.js via NodeSource PPA
    # Verbatim command from official NodeSource documentation
    #sudo apt update
    #sudo apt install -y ca-certificates curl gnupg
    #curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    #sudo apt install -y nodejs

	# 1. Install mise to ~/.local/bin (XDG-compliant binary path)
	curl https://mise.run | sh

	# Add ~/.local/bin only if it's not already there
	if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    	export PATH="$HOME/.local/bin:$PATH"
	fi

	# 3. Install Node.js (Latest)
	# mise use --global creates ~/.config/mise/config.toml
	mise use --global node@latest
}

# TODO - Add here a postinstall function to remind the zsh activation
# 
# This feels extra in our build as we required XDG
# path=("$HOME/.local/bin" $path)

# Activate mise (This handles node, npm, and gemini-cli shims)
# eval "$(mise activate zsh)"
