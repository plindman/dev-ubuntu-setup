# Coding Standards for dev-ubuntu-setup Scripts

This document describes the coding standards and practices used in this repository.

---

## Bash Script Standards

### Error Handling

All scripts should include `set -e` at the top:
```bash
set -e  # Exit immediately if a command exits with a non-zero status
```

For additional safety, scripts may also include:
```bash
set -o nounset   # Abort on unbound variable
set -o pipefail  # Don't hide errors within pipes
```

**Note:** Currently only `tmux.sh` uses the additional safety flags. Consider adding these to all scripts for consistency.

### Command Existence Checks

Use `command -v` instead of `which` for checking if a command exists:
```bash
# Good
if command -v zsh &> /dev/null; then
    echo "zsh is installed"
fi

# Avoid
if which zsh &> /dev/null; then
    echo "zsh is installed"
fi
```

**Why:** `command -v` is POSIX-compliant, built into the shell, and more reliable than `which`.

### Path Management

All scripts must set `REPO_ROOT` at the top:
```bash
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
```

Then source the helper library using `REPO_ROOT`:
```bash
source "$REPO_ROOT/lib/helpers.sh"
```

This ensures scripts work correctly regardless of where they are executed from.

---

## Package Installation Standards

### Two Approaches

1. **`install_and_show_versions()` function** - Use for standard package installations
   ```bash
   install_and_show_versions git-all curl wget
   ```
   - Provides version output after installation
   - Standardized error handling
   - Use when no official verbatim command is available

2. **Verbatim commands from official documentation** - Use as-is from official sources
   ```bash
   # Verbatim command from official NodeSource documentation
   sudo apt install -y nodejs
   ```
   - Always add a comment explaining it's verbatim
   - Preserves the exact official installation method
   - Useful for troubleshooting (matches official docs)

### When to Use Each

| Situation | Use |
|-----------|-----|
| Standard apt packages | `install_and_show_versions()` |
| Official docs provide specific commands | Verbatim (with comment) |
| Adding new apt repositories | Verbatim (requires update) |
| System operations (upgrade, remove) | Direct apt-get (with comment) |

### Update Calls

**Orchestrator scripts** (`install/system/install.sh`, `install/dev-tools/install.sh`):
- Run `apt-get update` once before running child scripts
- This is the authoritative update

**Child scripts should NOT run updates** except when:
- Adding a new apt repository (required before using the repo)
- Part of a verbatim installation command

---

## Helper Functions (`lib/helpers.sh`)

### Available Functions

| Function | Purpose | Usage |
|----------|---------|-------|
| `print_color` | Print colored output | `print_color "$GREEN" "message"` |
| `print_header` | Print section header | `print_header "Installing X"` |
| `print_info` | Print info message | `print_info "message"` |
| `print_success` | Print success message | `print_success "message"` |
| `print_warning` | Print warning message | `print_warning "message"` |
| `print_error` | Print error message | `print_error "message"` |
| `install_and_show_versions` | Install apt packages with version output | `install_and_show_versions pkg1 pkg2` |
| `run_script` | Run a script if it exists | `run_script "$path/script.sh"` |
| `command_exists` | Check if command exists | **Currently unused** - prefer inline `command -v` |

### command_exists() Function

This function exists in `lib/helpers.sh` but is intentionally unused:
```bash
command_exists() {
    command -v "$1" &> /dev/null
}
```

**Reason:** Inline `command -v` checks are more readable and don't require wrapping:
```bash
# More direct
if command -v node &> /dev/null; then
    ...
fi

# Less clear
if command_exists node; then
    ...
fi
```

The function remains available if a consistent use case emerges in the future.

---

## Code Organization

### Script Structure

```bash
#!/bin/bash

# Brief description of what the script does
# Reference to SOFTWARE_INDEX.md category

set -e

# Set repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

# Source the helper functions
source "$REPO_ROOT/lib/helpers.sh"

print_header "Starting installation of X"

# Script content...

print_color "$GREEN" "X installation complete."
```

### File Naming

- Use lowercase with hyphens for multi-word names: `nodejs.sh`, `gemini-cli.sh`
- Keep names descriptive and aligned with SOFTWARE_INDEX.md categories

### Comments

- Number steps when multiple distinct actions: `# 1. Install zsh`, `# 2. Install Oh My Zsh`
- Explain non-obvious actions: `# Necessary after adding a new apt repository`
- Reference official sources for verbatim commands: `# Verbatim command from official NodeSource documentation`

---

## XDG Compliance

This project follows the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html):

| Type | Location |
|------|----------|
| Config files | `~/.config/` |
| Data files | `~/.local/share/` |
| Cache files | `~/.cache/` |
| User binaries | `~/.local/bin/` |

Installations should respect XDG paths when possible (see `bun.sh` and `uv.sh` for examples).
