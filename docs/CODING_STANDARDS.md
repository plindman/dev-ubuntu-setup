# Coding Standards for dev-ubuntu-setup Scripts

This document describes the coding standards and practices used in this repository.

---

## Architecture: Module-Based Framework

The installation system is divided into **Modules** (data) and the **Framework** (logic).

### Installer Modules (`installers/`)

Installer scripts are pure configuration modules. They must **not** source any helpers or execute any commands when sourced.

**Structure:**
```bash
#!/bin/bash
# Description of the component

APP_NAME="Human Readable Name"
APP_COMMAND="command-to-verify" # Can be a string or an array ("cmd1" "cmd2")

install_component_name() {
    # Installation logic here
    # Use helpers like quiet_apt_install
}
```

**Naming Convention:**
Files must follow the pattern: `<category>-<index>-<name>.sh`
Example: `dev-tools-01-git.sh`, `system-05-tmux.sh`
The `index` (01, 02...) determines the execution order within the category.

### The Framework (`lib/module_runner.sh`)

The framework is responsible for:
1.  **Discovery**: Finding modules by category prefix via `_get_modules_for_category`.
2.  **Execution**: Sourcing modules and calling their `install_` or `verify_` logic.
3.  **Environment**: Providing the standard library (`output.sh`, `utils.sh`) to the modules.

---

## Bash Script Standards

### Error Handling

All scripts should include `set -e` at the top:
```bash
set -e  # Exit immediately if a command exits with a non-zero status
```

### Path Management

Avoid global variables for paths in sourced scripts.

**For sourcing dependencies:**
Use inline directory resolution:
```bash
source "$(dirname "${BASH_SOURCE[0]}")/lib/utils.sh"
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

### `quiet_apt_install()`

Use this helper for standard apt package installations:
```bash
quiet_apt_install pkg1 pkg2
```

### Verbatim Commands

Use verbatim commands from official documentation when specific repositories or complex installation steps are required. Always add a comment explaining it's a verbatim copy.

---

## Verification Pattern

The verification logic is decoupled from the installation logic.

1.  **`install.sh`**: Runs in installation mode via `install_category`.
2.  **`verify.sh`**: Runs in verification mode via `verify_category`.

Both rely on the `APP_COMMAND` variable defined in the installer modules or an optional `verify_` function for complex checks.

---

## Helper Functions (`lib/`)

### Output (`lib/output.sh`)
Provides colors and printing functions (`print_color`, `print_header`, `print_info`, `print_error`).

### Utilities (`lib/utils.sh`)
Provides system checks and package management:
| Function | Purpose |
|----------|---------|
| `command_exists` | Check if command exists |
| `package_installed` | Check if apt package is installed |
| `quiet_apt_install` | Install apt packages with version output |

---

## Code Organization

### File Naming
- Installers: `category-index-name.sh`
- Framework: `module_runner.sh`
- Libraries: `utils.sh`, `output.sh`

### XDG Compliance
Installations should respect XDG paths (`~/.config`, `~/.local/bin`, etc.) when possible.