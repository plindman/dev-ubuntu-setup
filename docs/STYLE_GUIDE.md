# Style Guide

This document outlines the coding and output conventions for scripts in this repository.

## Script Output Color Policy

To ensure console output is consistent and easy to understand, all scripts should use the `lib/helpers.sh` functions and adhere to the following color policy:

*   **BLUE (`print_header`)**: Used for major section headers to announce what a script or a major part of a script is about to do.

*   **GREEN (`print_color "$GREEN" ...`)**: Used for all success-related messages. This includes:
    *   Confirmation that an action has completed successfully (e.g., "Installation complete.").
    *   Confirmation that a component is already in the desired state (e.g., "Already installed, skipping.").

*   **YELLOW (`print_color "$YELLOW" ...`)**: Used for non-critical warnings that do not stop the script but that the user should be aware of. Examples include:
    *   Notifying the user of a potential conflict (e.g., detecting a legacy installation).
    *   Informing the user of a required manual step (e.g., "Please log out and back in for changes to take effect.").

*   **RED (`print_color "$RED" ...`)**: Reserved for critical errors and script failures. (Note: `set -e` should handle most of this, but it can be used for explicit error messages before exiting).
