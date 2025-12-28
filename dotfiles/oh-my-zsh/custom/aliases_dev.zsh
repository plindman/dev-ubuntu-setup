# My dev tooling
alias dev="cd ~/dev"

# AI tools
# Gemini CLI (https://geminicli.com/docs/get-started/installation/)
alias gemini="bunx @google/gemini-cli"

claude-glm() {
    # https://aiengineerguide.com/blog/claude-code-z-ai-glm-4-6/
    # secret-tool store --label=ApiKeyGLM apikey GLM
    local api_key
    api_key=$(secret-tool lookup apikey GLM) || return 1

    ANTHROPIC_BASE_URL="https://api.z.ai/api/anthropic" \
    ANTHROPIC_AUTH_TOKEN="$api_key" \
    claude "$@"
}
