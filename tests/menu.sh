#!/bin/bash
# Interactive test runner using fzf

# Navigate to project root
cd "$(dirname "$0")/.." || exit 1

if ! command -v fzf >/dev/null 2>&1; then
    echo "Error: fzf is not installed."
    exit 1
fi

while true; do
    # 1. Select Category (first item is the default in fzf)
    CHOICE=$(printf "Run Full Test\nRun Dry-run Test\nContainer (Apps)\nContainer (Category)\nHost Tests" | fzf --layout=reverse --prompt="Select Action > " --height=10 --border)

    # Exit if user cancels at category level
    [ -z "$CHOICE" ] && exit 0

    # 2. Handle selection
    case "$CHOICE" in
        "Run Full Install Test")
            TEST="tests/container/test_full_install_from_local_source.sh"
            ;;
        "Run Dry-run Test")
            TEST="tests/container/test_dry_run_from_local_source.sh"
            ;;
        "Container (Apps)")
            TEST=$( { printf "← Back\n"; find tests/container/apps -name "*.sh" | awk -F'/' '{print $NF "\t" $0}'; } | fzf --layout=reverse --prompt="Select App Test > " --delimiter=$'\t' --with-nth=1 | cut -f2-)
            # Check if user selected "Back"
            if [ "$TEST" = "← Back" ] || [ -z "$TEST" ]; then
                continue
            fi
            ;;
        "Container (Category)")
            TEST=$( { printf "← Back\n"; find tests/container/category -name "*.sh" | awk -F'/' '{print $NF "\t" $0}'; } | fzf --layout=reverse --prompt="Select Category Test > " --delimiter=$'\t' --with-nth=1 | cut -f2-)
            # Check if user selected "Back"
            if [ "$TEST" = "← Back" ] || [ -z "$TEST" ]; then
                continue
            fi
            ;;
        "Host Tests")
            TEST=$( { printf "← Back\n"; find tests/host -name "*.sh" | awk -F'/' '{print $NF "\t" $0}'; } | fzf --layout=reverse --prompt="Select Host Test > " --delimiter=$'\t' --with-nth=1 | cut -f2-)
            # Check if user selected "Back"
            if [ "$TEST" = "← Back" ] || [ -z "$TEST" ]; then
                continue
            fi
            ;;
    esac

    # Exit if no test selected (user cancelled)
    [ -z "$TEST" ] && exit 0

    # Check if test file exists
    if [ ! -f "$TEST" ]; then
        echo "Error: Test file not found: $TEST"
        exit 1
    fi

    # 3. Execute
    echo "==> Executing: $TEST"
    echo "================================================"

    if bash "$TEST"; then
        echo "================================================"
        echo -e "\033[0;32m✓ TEST PASSED\033[0m"
        exit 0
    else
        EXIT_CODE=$?
        echo "================================================"
        echo -e "\033[0;31m✗ TEST FAILED (exit code: $EXIT_CODE)\033[0m"
        exit $EXIT_CODE
    fi
done
