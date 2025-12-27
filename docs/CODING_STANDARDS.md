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

## Verification Pattern

All installation scripts must verify that the software was successfully installed after attempting installation. For categories with multiple installations (e.g., apps), use a centralized `verify.sh` file.

### Centralized verify.sh Pattern (Preferred for Multiple Installations)

For directories with multiple installable components, create a `verify.sh` with verification functions:

**`verify.sh` structure:**
```bash
#!/bin/bash

# Verification functions for [category] applications.
# Source this file to use verification functions in install scripts.

# Internal helper
_command_exists() {
    command -v "$1" &> /dev/null
}

# Verification functions for each component
verify_component_name() {
    _command_exists component-command
}

verify_another_component() {
    _command_exists another-command
}

# Optional: Show all installation status
show_all_status() {
    echo "[Category] Installation Status:"
    echo "================================"
    echo "Component Name:   $(verify_component_name && echo 'Installed' || echo 'Not installed')"
    echo "Another Component: $(verify_another_component && echo 'Installed' || echo 'Not installed')"
}
```

**Install script pattern:**
```bash
#!/bin/bash

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
source "$REPO_ROOT/lib/helpers.sh"
source "$REPO_ROOT/install/category/verify.sh"  # Source verify functions

print_header "Starting installation of Component Name"

# Check if already installed
if verify_component_name; then
    print_color "$GREEN" "Component Name is already installed. Skipping."
else
    # Installation commands here...

    # Verify installation
    if verify_component_name; then
        print_color "$GREEN" "Component Name installation complete."
    else
        print_color "$RED" "Component Name installation failed."
        exit 1
    fi
fi
```

### Benefits

1. **Reusable**: Verification functions used before install (skip if already installed) and after install (verify success)
2. **Single source of truth**: How each component is verified defined in one place
3. **Auditable**: Can run `show_all_status()` to see what's installed
4. **DRY principle**: No duplication of verification logic

### Simple Verification Pattern (Single Installations)

For standalone scripts installing a single component without a category:
```bash
#!/bin/bash

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
source "$REPO_ROOT/lib/helpers.sh"

print_header "Starting installation of Component"

# Check if already installed
if command -v component-command &> /dev/null; then
    print_color "$GREEN" "Component is already installed. Skipping."
else
    # Installation commands here...

    # Verify installation
    if command -v component-command &> /dev/null; then
        print_color "$GREEN" "Component installation complete."
    else
        print_color "$RED" "Component installation failed."
        exit 1
    fi
fi
```

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
