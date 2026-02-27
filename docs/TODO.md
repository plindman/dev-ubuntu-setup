# TODO - Future Improvements

This file tracks improvements and issues to address in future iterations.

---

## neovim PPA
Neovim installer to add apt ppa:neovim-ppa/stable so that we get newer version than ubuntu frozen.

## Chezmoi & Dotfiles Integration

chezmoi is now installed early (system-02-chezmoi.sh), but needs integration planning:

- **When** to apply dotfiles? After all packages? After shell setup?
- **How** to configure the dotfiles repo source? Env var? Config file?
- **Should** it be automatic in `install.sh --all` or a separate manual step?
- **Interaction** with system setup (zsh, tmux, etc.) - does chezmoi manage these configs?

---

## Test Coverage

Current test coverage is minimal. Consider adding tests for:

- **Dev-tools**: lazygit, gh, task, and others without dedicated tests
- **System**: individual component testing beyond full category tests
- **Integration**: test that dotfiles integration works when implemented
- **Edge cases**: failure scenarios, partial installations, re-runs

**Note**: Prioritize based on risk and complexity. Core infrastructure and complex installers should have tests first.

---

## Documentation: Download Utilities

Document the `download_file()` and `download_and_validate_script()` security pattern in CODING_STANDARDS.md to guide future installer scripts.

---

---


