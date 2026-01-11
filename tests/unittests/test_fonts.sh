#!/bin/bash

# Unit test for install/lib/fonts.sh logic
# Tests version parsing and formatting without external dependencies.

# 1. Mock the dependencies
print_color() { echo "$2"; }
GREEN=""

# 2. Source the library under test
source install/lib/output.sh
source install/lib/apt.sh
source install/lib/fonts.sh

# Mock dpkg-query
dpkg-query() {
    echo "  fonts-ibm-plex: 6.1.1-1"
}

# 3. Mock fc-list to return specific "hard" cases we've solved
fc-list() {
    local arg="$1"
    
    # Case 1: FiraCode (Needs 'Nerd Font' suffix)
    if [[ "$arg" == ":family=FiraCode Nerd Font" ]]; then
        echo "version=3.2.1"
    elif [[ "$arg" == ":family=FiraCode" ]]; then
        echo "" # Not found without suffix
        
    # Case 2: Libertinus (Large Integer -> needs fixed point math)
    # 462094 / 65536 ~= 7.051
    elif [[ "$arg" == ":family=Libertinus" ]]; then
        echo "fontversion=462094"
        
    # Case 3: Inter (Standard integer)
    elif [[ "$arg" == ":family=Inter" ]]; then
        echo "fontversion=4"
        
    else
        echo ""
    fi
}

echo "=== Running Unit Tests for Font Version Logic ==="

# Capture output
OUTPUT=$(print_font_versions "FiraCode" "Libertinus" "Inter")

echo "$OUTPUT"

# Assertions
echo "------------------------------------------------"
ERRORS=0

# Check FiraCode (Suffix handling)
if echo "$OUTPUT" | grep -q "FiraCode: 3.2.1"; then
    echo "✅ FiraCode: Suffix resolution worked"
else
    echo "❌ FiraCode: Failed to resolve version 3.2.1"
    ERRORS=$((ERRORS+1))
fi

# Check Libertinus (Fixed-point math)
if echo "$OUTPUT" | grep -q "Libertinus: 7.051 (462094)"; then
    echo "✅ Libertinus: Fixed-point math worked (462094 -> 7.051)"
else
    echo "❌ Libertinus: Failed to convert 462094 -> 7.051"
    ERRORS=$((ERRORS+1))
fi

# Check Inter (Standard)
if echo "$OUTPUT" | grep -q "Inter: 4"; then
    echo "✅ Inter: Standard integer passed through"
else
    echo "❌ Inter: Failed to report version 4"
    ERRORS=$((ERRORS+1))
fi

if [ $ERRORS -eq 0 ]; then
    echo "🎉 All unit tests passed."
    exit 0
else
    echo "💥 $ERRORS tests failed."
    exit 1
fi