# TODO - Future Improvements

This file tracks improvements and issues to address in future iterations.

---

## Security: Pipe-to-Shell Vulnerabilities

Several scripts download and execute code directly via pipe-to-shell, which is a security risk. Downloads should be:
1. Saved to a temporary file
2. Verified (checksum inspected)
3. Then executed

**Affected Files:**
- `install/system/zsh.sh:25` - Oh My Zsh installation
- `install/dev-tools/nodejs.sh:19` - Node.js installation
- `install/dev-tools/bun.sh:21` - Bun installation
- `install/dev-tools/uv.sh:21` - uv installation
- `install/dev-tools/claude-code.sh:20` - Claude Code installation

**Note:** While these downloads are from official sources, implementing proper download verification would improve security posture.
