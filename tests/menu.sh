#!/bin/bash
# Interactive test runner using fzf

# Navigate to project root
cd "$(dirname "$0")/.." || exit 1

if ! command -v fzf >/dev/null 2>&1;
    then
    echo "Error: fzf is not installed."
    exit 1
fi

# 1. Select Category
CATEGORY=$(printf "Container (Full/Core)\nContainer (Category)\nHost (Unit)\nHost (Local Verification)" | fzf --prompt="1. Select Category > " --height=10 --border)

[ -z "$CATEGORY" ] && exit 0

# 2. Select Test based on category
case "$CATEGORY" in
    "Container (Full/Core)")
        # List .sh files in tests/container (excluding subdirectories)
        TEST=$(find tests/container -maxdepth 1 -name "*.sh" | fzf --prompt="2. Select Test > ")
        ;;
    "Container (Category)")
        TEST=$(find tests/container/category -name "*.sh" | fzf --prompt="2. Select Test > ")
        ;;
    "Host (Unit)")
        TEST=$(find tests/host/unit -name "*.sh" | fzf --prompt="2. Select Test > ")
        ;;
    "Host (Local Verification)")
        TEST="tests/host/test_fonts_local.sh"
        ;;
esac

[ -z "$TEST" ] || [ ! -f "$TEST" ] && exit 0

# 3. Execute
echo "==> Executing: $TEST"
echo "------------------------------------------------"
bash "$TEST"
