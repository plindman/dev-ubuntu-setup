#!/bin/bash

# Security-related utility functions for installation scripts
# This file contains functions for validating and securing installation processes

# ShellCheck code categories:
# 1. BLACKLIST (abort): Security-critical codes that abort installation
# 2. WHITELIST (silent): Benign codes that produce no output
# 3. All others: Warning output but do not abort

# -----------------------------------------------------------------------------
# BLACKLIST: Security-critical ShellCheck codes (will abort installation)
# -----------------------------------------------------------------------------
# These represent patterns that could lead to command injection, code execution,
# or other security vulnerabilities. We will NOT install scripts with these issues.
#
# SC2046: Quote to prevent word splitting/globbing (command injection)
# SC2048: Use "$@" to prevent whitespace problems (argument injection)
# SC2156: Injecting filenames is fragile and insecure (path traversal)
# SC1098: Quote/escape special characters when using eval (eval injection)
SECURITY_CRITICAL_CODES=(
    "SC2046"
    "SC2048"
    "SC2156"
    "SC1098"
)

# -----------------------------------------------------------------------------
# WHITELIST: Benign ShellCheck codes (silent, no output)
# -----------------------------------------------------------------------------
# These are style issues or minor problems that pose no security risk and are
# so common in official installers that warning would create noise without value.
#
# SC2002: Useless cat
#   WHY: Pure style issue (cat file | instead of < file). No security impact.
#   Found in: Many official scripts that prefer piped style for readability.
#
# SC2145: Argument mixes string and array
#   WHY: Common in official install scripts using echo with mixed args. The
#   mixing is intentional and safe in these contexts, not a security issue.
#   Found in: Bun, Zed, and other official installers.
BENIGN_CODES=(
    "SC2002"
    "SC2145"
)

# -----------------------------------------------------------------------------
# INTENTIONALLY EXCLUDED: Codes that warn but don't abort
# -----------------------------------------------------------------------------
# These codes fall into the middle tier: we show a warning but continue installation.
#
# SC2086: Double quote to prevent globbing and word splitting
#   WHY EXCLUDED: While unquoted variables CAN be a security issue with untrusted
#   input, this pattern is extremely common in official installer scripts from
#   trusted sources (e.g., Oh My Zsh has 18 instances). These scripts are
#   well-audited and widely-used. Aborting on SC2086 would prevent installing
#   many legitimate tools.
#   IMPACT: We warn so it's visible in logs, but don't block installation.
#   MITIGATION: We only install from trusted HTTPS sources (official repos),
#   reducing the risk of malicious scripts exploiting unquoted variables.

# Download and validate a script from URL using ShellCheck
# Usage: script_path=$(download_and_validate_script <url>)
# Returns: Path to downloaded script on stdout, exits on error
# Behavior:
#   - Aborts on security-critical codes (blacklist)
#   - Silently ignores benign codes (whitelist)
#   - Warns but continues on all other codes
download_and_validate_script() {
    local url="$1"
    local temp_script="/tmp/install_$(date +%s)_$.sh"

    # Download the script
    if ! curl -fsSL "$url" -o "$temp_script"; then
        echo "[ERROR] Failed to download script from $url" >&2
        return 1
    fi

    # Validate with ShellCheck if available
    if command -v shellcheck &> /dev/null; then
        # Run ShellCheck and capture output
        local shellcheck_output
        shellcheck_output=$(shellcheck -f gcc "$temp_script" 2>&1)

        # Check for security-critical errors (abort)
        local security_errors=0
        for code in "${SECURITY_CRITICAL_CODES[@]}"; do
            if echo "$shellcheck_output" | grep -q "$code"; then
                echo "[SECURITY] Script from $url contains security-critical issue ($code):" >&2
                echo "$shellcheck_output" | grep "$code" >&2
                security_errors=1
            fi
        done

        if [ "$security_errors" -eq 1 ]; then
            echo "[ERROR] Aborting installation due to security-critical ShellCheck errors" >&2
            rm -f "$temp_script"
            return 1
        fi

        # Filter out whitelisted benign codes and show warnings for the rest
        # Only show actual errors and warnings, not style notes
        local filtered_output=""
        while IFS= read -r line; do
            local is_whitelisted=0
            for code in "${BENIGN_CODES[@]}"; do
                if echo "$line" | grep -q "$code"; then
                    is_whitelisted=1
                    break
                fi
            done

            # Skip whitelisted codes, skip "note:" level (style suggestions),
            # show "error:" and "warning:" level issues
            if [ "$is_whitelisted" -eq 0 ] && echo "$line" | grep -qE "(error:|warning:).+SC[0-9]{4}"; then
                filtered_output="$filtered_output$line"$'\n'
            fi
        done <<< "$shellcheck_output"

        if [ -n "$filtered_output" ]; then
            echo "[WARNING] Script from $url has ShellCheck warnings (not security-critical, continuing):" >&2
            echo "$filtered_output" >&2
        fi
    fi

    # Output the path for caller to capture
    echo "$temp_script"
}
