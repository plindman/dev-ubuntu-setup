# Test Suite

This directory contains scripts to verify the installation process in various environments.

## Directory Structure

- **`host/`**: Tests that run directly on your machine.
  - **`unit/`**: Fast logic-only tests without external dependencies.
  - **`test_fonts_local.sh`**: Verifies the actual font state on your host machine.
- **`container/`**: Tests that utilize Docker for isolation.
  - **`category/`**: Integration tests for specific installer categories.
  - **`commands/`**: Shell command templates passed to Docker.
  - **`scripts/`**: Static scripts (like `install_from_source.sh`) executed within the container.
- **`lib/`**: Shared host-side framework logic.

## Usage

### Docker Integration Tests
These tests simulate a fresh Ubuntu installation.

#### Full Installation Simulation
```bash
./tests/container/test_full.sh
```

#### Category Tests
```bash
./tests/container/category/test_apps.sh
```

### Local Machine & Unit Tests

#### Local Font Verification
```bash
./tests/host/test_fonts_local.sh
```

#### Unit Tests
```bash
./tests/host/unit/test_fonts.sh
```

## Architecture
- **Base Image**: The `Dockerfile` in this directory builds a cached image with a clean Ubuntu environment.
- **Simulation**: `lib/docker_utils.sh` handles container lifecycle and command execution.
- **Internal Commands**: Files in `container/commands/` are passed as text to Docker containers.