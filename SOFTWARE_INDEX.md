# Development Workstation Software Index

This document provides a comprehensive overview of all software components managed by the `dev-workstation-setup` repository, categorized by their function and type.

---

## System

These are core operating system utilities and essential command-line tools that form the foundation of the workstation. They are generally always installed.

### Core
*   **Update & Upgrade**: Ensures the system is fully up-to-date and stable using the latest package versions.
*   **apt-transport-https**: Secures package downloads by enabling APT to access repositories over HTTPS.
*   **ca-certificates**: Validates SSL/TLS connections using a set of common Certificate Authorities.
*   **gnupg**: Provides cryptographic services and verification for package signatures.
*   **lsb-release**: Identifies the Linux distribution version, a requirement for many scripts and PPA additions.

### System Services
*   **openssh-server**: A fundamental service to allow remote access to the machine.

### Shell
*   **zsh**: An extended Bourne shell with powerful features and improvements for an enhanced command-line experience.
*   **Oh My Zsh**: A framework for easily managing Zsh configuration, themes, and plugins. (Note: Many themes require a Nerd Font like Font Awesome to be installed in the desktop environment for icons to render correctly).
*   **tmux**: A terminal multiplexer for managing multiple terminal sessions.
*   **Oh My Tmux**: A configuration framework for `tmux`.

### Editors
*   **nano**: A simple, user-friendly command-line text editor for quick and straightforward edits.
*   **micro**: A modern, intuitive, and feature-rich terminal-based text editor.
*   **neovim**: A highly extensible Vim-based text editor for powerful and efficient text manipulation.

### System Tools
*   **htop**: An interactive tool for monitoring system processes.
*   **keychain**: A tool for managing SSH/GPG agent sessions.

### Networking Tools
*   **curl**: A tool for transferring data from or to a server.
*   **wget**: A tool for non-interactively downloading files.

---

## Development Tools (CLI)

These are essential command-line tools and utilities specifically tailored for software development. They are independent of a graphical environment.

### Tools
*   **build-essential**: Provides low-level compilers (like C/C++) that act as a foundational "safety net," as they are often a hidden dependency for installing other development tools and libraries from source.
*   **ripgrep**: A line-oriented search tool that recursively searches your current directory for a regex pattern. It's a faster alternative to `grep` for code.

### Git
*   **git-all**: The version control system for managing code.
*   **gh**: The official GitHub CLI for interacting with repositories.

### Runtimes & Package Managers
#### JavaScript & TypeScript
*   **Node.js**: The primary JavaScript runtime, used for a wide range of server-side and tooling applications.
*   **bun**: A fast, all-in-one JavaScript runtime, bundler, and package manager, used for newer projects.
#### Python
*   **uv**: An extremely fast Python package installer and resolver.

### AI & LLM Tools
*   **Gemini CLI**: A command-line interface for interacting with Google's Gemini models.
*   **Claude Code**: A command-line tool for interacting with Anthropic's Claude models.

### Services
*   **Docker Engine & CLI**: A containerization platform to build and run applications.
*   **VS Code Server**: A backend service to enable remote development from another machine. Installed from client over SSH so nothing we install here on dev machine.

---

## Desktop

These packages and configurations are specific to a graphical desktop environment (GUI) and should only be installed on a workstation with a display.

### Core Desktop Components
*   **gnome-tweaks**: Provides a tool for advanced customization of the GNOME desktop.
*   **gnome-shell-extension-manager**: Manages GNOME Shell extensions.
*   **gnome-keyring**: A background service that stores passwords and secrets for the desktop environment.
*   **libsecret-tools**: 

### Desktop Utilities
*   **nemo**: Installs the Nemo file manager.
*   **synaptic**: A graphical package manager for `apt`.

---

## Applications (GUI)

This category includes all user-facing graphical applications, for both general and development purposes.

### Web Browsers
*   **Chrome**: A popular web browser from Google.
*   **Brave**: A privacy-focused web browser based on Chromium.
*   **Vivaldi**: A highly customizable web browser for power users.

### Development
*   **VS Code**: A popular and highly extensible source-code editor.
*   **Zed Editor**: A high-performance, multiplayer code editor from the creators of Atom and Tree-sitter.
*   **Kate**: A powerful text editor with advanced features like syntax highlighting and a built-in terminal.
*   **Google Antigravity**: An AI-first IDE for agentic development.
*   **Ghostty**: A GPU-accelerated terminal emulator.

---

## Optional Software

Heavy or specialized software that is not installed by default.

*   **TexLive (Full)**: A comprehensive TeX system with all available packages and fonts (~5GB).
*   **TeXstudio**: A feature-rich LaTeX editor with integrated PDF viewer and advanced syntax highlighting.

