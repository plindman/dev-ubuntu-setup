#!/bin/bash

# Module Runner Logic
# Handles dynamic discovery and execution of installer modules.

# Load helpers (foundational output first, then others)
source "$(dirname "${BASH_SOURCE[0]}")/output.sh"
for lib in "$(dirname "${BASH_SOURCE[0]}")"/*.sh; do
    # Skip output.sh since it's already sourced, and skip this file
    if [[ "$lib" != *"output.sh" ]] && [[ "$lib" != *"module_runner.sh" ]]; then
        source "$lib"
    fi
done

# Internal helper to verify if app is installed
_verify_app_status() {
    # 1. Check for custom verify function defined in the module
    # The convention is verify_<component_name>
    # We must exclude verify_details_* functions which are for reporting only
    local verify_func=$(grep -o "^verify_[a-zA-Z0-9_]*" "$file" | grep -v "^verify_details_" | head -n 1)

    if [[ -n "$verify_func" ]] && declare -f "$verify_func" > /dev/null; then
        $verify_func
        return $?
    fi

    # 2. Fallback to APP_COMMAND tuple/string
    if [[ -z "${APP_COMMAND:-}" ]]; then
        return 0
    fi

    local cmds=()
    if [[ "$(declare -p APP_COMMAND 2>/dev/null)" == "declare -a"* ]]; then
        cmds=("${APP_COMMAND[@]}")
    else
        cmds=("$APP_COMMAND")
    fi

    for cmd in "${cmds[@]}"; do
        if ! command_exists "$cmd"; then
            return 1
        fi
    done
    return 0
}

# Internal helper to get module files for a category
# Returns an array of file paths
_get_modules_for_category() {
    local category="$1"
    local my_dir="$(dirname "${BASH_SOURCE[0]}")"
    local installer_dir="$my_dir/../installers"
    
    # Return the glob pattern expansion
    echo "$installer_dir/${category}"-*.sh
}

install_category() {
    local category="$1"
    
    print_header "Installing Category: $category"

    # Use bash array expansion with the glob returned by helper
    local files=($(_get_modules_for_category "$category"))
    
    # Check if files exist (handling the case where glob returns the pattern itself if no match)
    if [ ! -e "${files[0]}" ]; then
        print_warning "No modules found for category: $category"
        return
    fi

    for file in "${files[@]}"; do
        install_module "$file"
    done
}

verify_category() {
    local category="$1"
    
    print_header "Verifying Category: $category"

    local files=($(_get_modules_for_category "$category"))
    
    if [ ! -e "${files[0]}" ]; then
        print_warning "No modules found for category: $category"
        return
    fi

    for file in "${files[@]}"; do
        verify_module "$file"
    done
}

list_category_apps() {
    local category="$1"
    
    print_header "Apps in Category: $category"

    local files=($(_get_modules_for_category "$category"))
    
    if [ ! -e "${files[0]}" ]; then
        print_warning "No modules found for category: $category"
        return
    fi

    for file in "${files[@]}"; do
        (
            source "$file"
            echo " - $APP_NAME"
        )
    done
}


install_module() {
    local file="$1"
    (
        source "$file"
        
        if _verify_app_status; then
            print_color "$GREEN" "$APP_NAME is already installed. Skipping."
            return
        fi
        
        print_info "Installing $APP_NAME..."
        
        local func_name=$(grep -o "^install_[a-zA-Z0-9_]*" "$file" | head -n 1)
        if [[ -n "$func_name" ]] && declare -f "$func_name" > /dev/null; then
             $func_name
        else
             print_error "Could not find a valid install function in $file"
             exit 1
        fi

        if _verify_app_status; then
            print_color "$GREEN" "$APP_NAME installation complete."
            
            # Check for optional post-install info function
            local info_func=$(grep -o "^post_install_info_[a-zA-Z0-9_]*" "$file" | head -n 1)
            if [[ -n "$info_func" ]] && declare -f "$info_func" > /dev/null; then
                print_color "$CYAN" "\n--- Post-Install Instructions for $APP_NAME ---"
                $info_func
                echo ""
            fi
        else
            print_color "$RED" "$APP_NAME installation failed."
            exit 1
        fi
    )
}

verify_module() {
    local file="$1"
    (
        source "$file"
        if _verify_app_status; then
            print_color "$GREEN" "✅ [OK] $APP_NAME"
        else
            print_color "$RED" "❌ [MISSING] $APP_NAME"
            
            # Look for optional details function: verify_details_<component>
            local details_func=$(grep -o "^verify_details_[a-zA-Z0-9_]*" "$file" | head -n 1)
            if [[ -n "$details_func" ]] && declare -f "$details_func" > /dev/null; then
                $details_func
            fi
        fi
    )
}