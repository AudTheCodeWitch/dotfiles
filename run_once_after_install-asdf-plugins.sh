#!/bin/bash

# 1. Initialize Homebrew environment variables for this execution instance
if [[ -x "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 2. Verify the core asdf binary is accessible
if ! command -v asdf >/dev/null; then
    echo "❌ asdf binary not found in PATH. Skipping plugin sync."
    exit 1
fi

TOOL_VERSIONS="$HOME/.tool-versions"

if [[ ! -f "$TOOL_VERSIONS" ]]; then
    echo "⚠️ No global .tool-versions file found at $TOOL_VERSIONS. Skipping."
    exit 0
fi

echo "🚀 Dynamically synchronizing asdf plugins from $TOOL_VERSIONS..."

# 3. Parse and install missing plugins directly via the CLI binary
awk '!/^[[:space:]]*#/ && NF {print $1}' "$TOOL_VERSIONS" | while read -r plugin; do
    if ! asdf plugin list 2>/dev/null | grep -q "^${plugin}$"; then
        echo "➕ Adding missing plugin: $plugin"
        asdf plugin add "$plugin"
    else
        echo "✅ Plugin already active: $plugin"
    fi
done

# 4. Install missing runtime versions declared in .tool-versions
echo "📦 Installing missing runtime versions from $TOOL_VERSIONS..."
echo "⚠️ Note: Compiling Ruby can take several minutes. Hang tight."
asdf install

# 5. Reshim to lock down binary paths immediately
echo "🔄 Reshimming asdf binaries..."
asdf reshim
echo "✨ All runtimes synchronized and ready."
