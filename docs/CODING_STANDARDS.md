# Coding Standards for dev-ubuntu-setup Scripts

This document describes the coding standards and practices used in this repository.

---

## Architecture: Module-Based Framework

The installation system is divided into **Modules** (data) and the **Framework** (logic).

### Installer Modules (`install/installers/`)

Installer scripts are pure configuration modules. They must **not** source any helpers or execute any commands when sourced.

**Structure:**
```bash
#!/bin/bash
# Description of the component

APP_NAME="Human Readable Name"
APP_COMMAND="command-to-verify" # Can be a string or an array ("cmd1" "cmd2")

install_component_name() {
    # Installation logic here
    # Use helpers like install_and_show_versions
}
```

**Naming Convention:**
Files must follow the pattern: `<category>-<index>-<name>.sh`
Example: `devtools-01-git.sh`, `system-05-tmux.sh`
The `index` (01, 02...) determines the execution order within the category.

### The Framework (`install/lib/module_runner.sh`)

The framework is responsible for:
1.  **Discovery**: Finding modules by category prefix.
2.  **Execution**: Sourcing modules and calling their `install_` or `verify_` logic.

---

## Bash Script Standards

### Error Handling

All scripts should include `set -e` at the top:
```bash
set -e  # Exit immediately if a command exits with a non-zero status
```

### Path Management

Avoid global variables for paths.

**For sourcing dependencies:**
Use inline directory resolution:
```bash
source "$(dirname "${BASH_SOURCE[0]}")/lib/helpers.sh"
```

**For path usage inside functions:**
Use `local` variables:
```bash
my_function() {
    local base_dir="$(dirname "${BASH_SOURCE[0]}")"
    # ...
}
```

---

## Package Installation Standards

### `install_and_show_versions()`

Use this helper for standard apt package installations:
```bash
install_and_show_versions pkg1 pkg2
```

### Verbatim Commands

Use verbatim commands from official documentation when specific repositories or complex installation steps are required. Always add a comment explaining it's a verbatim copy.

---

## Verification Pattern

The verification logic is decoupled from the installation logic.

1.  **`install.sh`**: Runs in installation mode, calling `install_module` which checks existence, installs if missing, and verifies success.
2.  **`verify.sh`**: Runs in verification mode, calling `verify_module` which only checks existence and reports status.

Both rely on the `APP_COMMAND` variable defined in the installer modules.

---

## Helper Functions (`lib/helpers.sh`)

| Function | Purpose | Usage |
|----------|---------|-------|
| `print_color` | Print colored output | `print_color "$GREEN" "msg"` |
| `print_header` | Print section header | `print_header "Header"` |
| `command_exists` | Check if command exists | `command_exists cmd` |
| `package_installed` | Check if apt package is installed | `package_installed pkg` |

---

## Code Organization

### File Naming
- Installers: `category-index-name.sh`
- Logic: `logic-name.sh` or `module_runner.sh`
- Helpers: `name.sh`

### XDG Compliance
Installations should respect XDG paths (`~/.config`, `~/.local/bin`, etc.) when possible.
