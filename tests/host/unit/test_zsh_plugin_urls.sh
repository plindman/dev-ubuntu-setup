#!/bin/bash
# Verify that Zsh plugin URLs defined in the installer are valid.

source "$(cd "$(dirname "${BASH_SOURCE[0]}")"; while [ ! -f lib/config.sh ] && [ "$PWD" != "/" ]; do cd ..; done; pwd)/lib/config.sh"

# Source the installer to get ZSH_PLUGINS and POWERLEVEL10K_URL
source "$PROJECT_ROOT/install/installers/system-04-zsh.sh"

echo "=== Verifying Zsh Plugin URLs ==="

# Collect URLs into a single list for verification
ALL_URLS=("$POWERLEVEL10K_URL")
for p in "${ZSH_PLUGINS[@]}"; do
    ALL_URLS+=("${p#*|}")
done

ERRORS=0
for url in "${ALL_URLS[@]}"; do
    printf "Checking %-60s " "$url..."
    if git ls-remote "$url" HEAD >/dev/null 2>&1; then
        echo "✅ OK"
    else
        echo "❌ FAILED"
        ERRORS=$((ERRORS+1))
    fi
done

if [ $ERRORS -eq 0 ]; then
    echo "All URLs verified."
    exit 0
else
    echo "$ERRORS URLs failed verification."
    exit 1
fi