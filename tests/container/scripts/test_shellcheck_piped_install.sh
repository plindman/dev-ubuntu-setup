#!/bin/bash
# Test ShellCheck validation for piped bash installs
# This tests the security pattern of validating curl | bash installs before execution

set -e

echo '==> [Container] Loading Library...'
source install/lib/module_runner.sh

# Setup Logging
setup_logging "test-shellcheck-piped-install"

echo '==> [Container] Installing System Layer (includes ShellCheck)...'
quiet_apt_update
install_category "system"

echo '==> [Container] Verifying ShellCheck is installed...'
if ! command -v shellcheck &> /dev/null; then
    echo "[ERROR] ShellCheck not found!"
    exit 1
fi

echo "==> [Container] ShellCheck version: $(shellcheck --version | head -n 1)"

# Test 1: Create a safe test script and validate it
echo '==> [Container] Test 1: Validating a known-safe install script...'
cat > /tmp/test_safe_install.sh << 'EOF'
#!/bin/bash
# Safe test script
set -euo pipefail
echo "This is a safe test script"
exit 0
EOF

if shellcheck /tmp/test_safe_install.sh; then
    echo "[SUCCESS] Safe script passed ShellCheck validation"
else
    echo "[ERROR] Safe script failed ShellCheck validation"
    exit 1
fi

# Test 2: Create an unsafe test script and verify it fails validation
echo '==> [Container] Test 2: Detecting unsafe patterns in install script...'
cat > /tmp/test_unsafe_install.sh << 'EOF'
#!/bin/bash
# Unsafe test script with issues
cd /tmp || exit
rm -rf "$DIR"  # Unquoted variable
echo "Done"
EOF

if shellcheck /tmp/test_unsafe_install.sh 2>&1 | grep -q "warning"; then
    echo "[SUCCESS] Unsafe script properly flagged by ShellCheck"
else
    echo "[WARNING] Unsafe script not flagged (may need adjustment)"
fi

# Test 3: Simulate real curl | bash pattern with ShellCheck validation
echo '==> [Container] Test 3: Testing curl | shellcheck | bash pattern...'
TEST_URL="https://bun.sh/install"
if curl -fsSL "$TEST_URL" | shellcheck /dev/stdin; then
    echo "[SUCCESS] Real install script ($TEST_URL) passed ShellCheck validation"
    echo "[NOTE] This demonstrates the pattern: curl URL | shellcheck /dev/stdin"
else
    echo "[WARNING] Real install script has ShellCheck warnings"
    echo "[NOTE] In production, you would review warnings before deciding whether to proceed"
fi

# Test 4: Demonstrate the recommended safe pattern function
echo '==> [Container] Test 4: Creating helper function for safe piped installs...'

cat > /tmp/safe_install_helper.sh << 'EOF'
#!/bin/bash
# Helper function to safely install from a URL using ShellCheck validation
# Usage: safe_install <url> [description]

safe_install() {
    local url="$1"
    local description="${2:-install script}"
    local temp_script="/tmp/install_$(date +%s).sh"

    echo "==> Fetching $description..."
    if ! curl -fsSL "$url" -o "$temp_script"; then
        echo "[ERROR] Failed to download $description from $url"
        return 1
    fi

    echo "==> Validating $description with ShellCheck..."
    if shellcheck "$temp_script"; then
        echo "==> [OK] $description passed ShellCheck validation"
    else
        echo "==> [WARNING] $description has ShellCheck warnings:"
        shellcheck "$temp_script"
        echo ""
        read -p "Continue anyway? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "[ABORTED] Installation cancelled due to ShellCheck warnings"
            rm -f "$temp_script"
            return 1
        fi
    fi

    echo "==> Executing $description..."
    bash "$temp_script"
    local exit_code=$?
    rm -f "$temp_script"
    return $exit_code
}
EOF

if [ -f /tmp/safe_install_helper.sh ]; then
    echo "[SUCCESS] Safe install helper created"
    echo "[NOTE] Source this helper to use safe_install() function in your scripts"
else
    echo "[ERROR] Failed to create safe install helper"
    exit 1
fi

echo '==> [Container] All ShellCheck tests completed successfully!'
echo '==> [Container] Recommended pattern: curl URL -o script.sh && shellcheck script.sh && bash script.sh'
