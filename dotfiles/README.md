# Dotfiles Management

This directory contains all personal configuration files (dotfiles) that will be managed and deployed by the `dev-workstation-setup` scripts. The goal is to create a consistent and personalized environment across different machines.

## XDG Compliance

As outlined in the main `README.md`, we adhere to the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html). This means configurations are stored in `~/.config` where possible, keeping the `$HOME` directory clean.

The installation script will be responsible for symlinking these files to their correct locations. For XDG-compliant configurations, the directory structure within `dotfiles/config` will mirror the structure required in `~/.config`.

## Planned Dotfiles

Below is a list of applications and the configuration files we plan to manage.

---

### System & Shell

*   **Zsh & Oh My Zsh**:
    *   `zsh/.zshrc`: Main configuration for the interactive shell, including aliases, functions, paths, and plugin management. Will source Oh My Zsh.
    *   `zsh/.zshenv`: For setting environment variables that should be available to all processes, not just the interactive shell.
    *   `zsh/.p10k.zsh`: Configuration for the Powerlevel10k theme, if used.
    *   `oh-my-zsh/custom/`: For custom plugins, themes, and scripts that extend Oh My Zsh. These will be symlinked into the OMZ installation.
*   **tmux & Oh My Tmux**:
    *   `config/tmux/tmux.conf`: Main `tmux` configuration, which will also handle sourcing the `gpakosz/.tmux` framework.
    *   `config/tmux/tmux.conf.local`: User-specific customizations for `tmux` and `Oh My Tmux`. These files will be symlinked to `~/.config/tmux/`.
    *   **Note on `gpakosz/.tmux`**: The framework itself (`gpakosz/.tmux` repository) is expected to be cloned into `~/.tmux`. The `~/.config/tmux/tmux.conf` will be responsible for sourcing the main `tmux.conf` from the cloned framework.
*   **Keychain**:
    *   Configuration will be handled within `.zshrc` to manage SSH/GPG agent sessions.

---

### Development Tools

*   **Git**:
    *   `git/.gitconfig`: Global Git configuration, including user identity, aliases, and editor preferences.
    *   `git/.gitignore_global`: A global set of file patterns to ignore in all Git repositories.
*   **Editors (CLI)**:
    *   `config/nvim/`: Directory for Neovim configuration (`init.lua` and other Lua modules).
    *   `config/micro/settings.json`: Settings for the `micro` editor.
    *   `config/nano/nanorc`: Configuration for `nano`.
*   **System Monitoring**:
    *   `config/htop/htoprc`: Configuration for the `htop` process monitor, including layout and display options.
*   **Python**:
    *   `config/uv/uv.toml`: Configuration for the `uv` package installer.

---

### AI & LLM Tools (Non-XDG)

These tools create configuration files directly in the user's home directory and do not follow the XDG specification.

*   **Gemini CLI**:
    *   `.gemini/settings.json`: Configuration for the Gemini CLI.
    *   `.gemini/GEMINI.md`: Potentially for storing prompts or context.

---

### GUI Applications

These configurations are for graphical applications and will be symlinked into `~/.config`.

*   **VS Code**:
    *   `config/Code/User/settings.json`: User-specific settings.
    *   `config/Code/User/keybindings.json`: Custom keyboard shortcuts.
*   **Google Antigravity**:
    *   `config/Antigravity/`: Directory for Antigravity IDE settings.
*   **Ghostty Terminal**:
    *   `config/ghostty/config`: Configuration for the Ghostty terminal emulator.
*   **Nemo File Manager**:
    *   `config/nemo/`: Directory for Nemo file manager settings (e.g., UI preferences).


---

### File Structure and Symlinking Strategy

To make the symlinking process clear, here is the intended mapping from this `dotfiles` repository to your home directory (`~`), in order of preference:

*   **Rule 1: XDG Configurations (`~/.config`)**
    *   The contents of the `dotfiles/config/` directory map to `~/.config/`. The installation script will symlink files and directories from here to their corresponding location inside `~/.config/`.
    *   Example: `dotfiles/config/htop/htoprc` -> `~/.config/htop/htoprc`.

*   **Rule 2: Dedicated Home Sub-directories (`~/.<name>`)**
    *   Some tools require a dedicated directory in your home folder (e.g., `~/.gemini`, `~/.oh-my-zsh/custom`). For these, the contents of the corresponding directory in this repository will be symlinked into place.
    *   Example: `dotfiles/.gemini/settings.json` -> `~/.gemini/settings.json`.
    *   Example: `dotfiles/oh-my-zsh/custom/themes/` -> `~/.oh-my-zsh/custom/themes/`.

*   **Rule 3: Root Home Files (`~`)**
    *   Files that belong in the root of your home directory (e.g. `~/.zshrc`) are organized into subdirectories here for tidiness (e.g., `zsh/`, `git/`). The symlinking script will link the *files inside* these organizational folders to their destination in `~`.
    *   Example: `dotfiles/zsh/.zshrc` -> `~/.zshrc`.

The example structure below follows these rules.

### File Structure Example

The structure within this `dotfiles` directory will be organized for easy symlinking.

```
dotfiles/
├── config/               # Rule 1: Maps to ~/.config/
│   ├── nvim/             # -> ~/.config/nvim/
│   ├── micro/            # -> ~/.config/micro/
│   ├── tmux/             # -> ~/.config/tmux/
│   │   ├── tmux.conf     # Main tmux config
│   │   └── tmux.conf.local # User customizations
│   └── htop/             # -> ~/.config/htop/
├── .gemini/              # Rule 2: Contents symlinked to ~/.gemini/
├── oh-my-zsh/            # Rule 2: Contents symlinked to ~/.oh-my-zsh/custom/
│   └── custom/
├── git/                  # Rule 3: Organizational directory
│   ├── .gitconfig        # -> ~/.gitconfig
│   └── .gitignore_global # -> ~/.gitignore_global
├── zsh/                  # Rule 3: Organizational directory
│   ├── .zshrc            # -> ~/.zshrc
│   ├── .zshenv           # -> ~/.zshenv
│   └── .p10k.zsh         # -> ~/.p10k.zsh
└── README.md
```
**Note**: This structure is a proposal and will be built out as we create the actual configuration files.