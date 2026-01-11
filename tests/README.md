# Test Suite

This directory contains scripts to verify the installation process in various environments.

## Integration Tests (Docker)

These tests use Docker to simulate a fresh Ubuntu installation.

### 1. Full Installation Simulation
Simulates a fresh `git clone` and install using your *current local code* (mounted into the container). This is the primary test for developers working on the repo.
```bash
./tests/test_local.sh
```

### 2. Font Integration Test
Specifically tests the font installation module (downloading, unzipping, `fc-cache`, and version checks) in a clean container.
```bash
./tests/test_fonts_docker.sh
```

## Local Machine Tests

### 1. Local Font Verification
Checks if the fonts expected by this repository are correctly installed and registered on your *actual* machine. This uses the project's internal library logic to report versions.
```bash
./tests/test_fonts_local.sh
```

## Unit Tests

### 1. Font Logic Unit Test
Tests the parsing logic, suffix resolution, and fixed-point version conversion without any external dependencies or font installations.
```bash
./tests/unittests/test_fonts.sh
```

## Architecture
- **Base Image**: The `Dockerfile` in this directory builds a cached image with a clean Ubuntu environment and a non-root user with `sudo` access.
- **Simulation**: `docker_utils.sh` handles container lifecycle.
- **Local Install**: `local_install.sh` is used inside the container to simulate the setup process using the mounted source code instead of cloning from GitHub.
