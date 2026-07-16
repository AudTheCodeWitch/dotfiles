# ==============================================================================
# 🚀 MODERN RUST/CLI ENHANCEMENTS & REPLACEMENTS
# ==============================================================================

# Replace 'ls' with 'eza' (styled directory viewer with Git status icons)
if command -v eza >/dev/null; then
    alias ls="eza --icons --color=always --group-directories-first"
    alias la="eza --icons --color=always --group-directories-first --all"
    alias ll="eza --icons --color=always --group-directories-first --long --git"
    alias tree="eza --icons --color=always --tree"
fi

# Replace 'cat' with 'bat' (syntax highlighted file viewer)
if command -v bat >/dev/null; then
    alias cat="bat --style=plain"
    export MANPAGER="sh -c 'col -bx | bat -l man -p'" # Syntax highlight manual pages!
fi

# Replace 'df' with 'duf' (beautiful modern disk usage statistics)
if command -v duf >/dev/null; then
    alias df="duf"
fi

# ==============================================================================
# 📦 MODERN REPLACEMENT ENGINE INITIALIZATIONS
# ==============================================================================

# Zoxide (Smart directory jumper - replaces 'cd')
if command -v zoxide >/dev/null; then
    eval "$(zoxide init zsh)"
fi

# Direnv (Loads/unloads directory-specific env files automatically)
if command -v direnv >/dev/null; then
    eval "$(direnv hook zsh)"
fi

# FZF (Interactive Fuzzy History Finder Integration)
if command -v fzf >/dev/null; then
    source <(fzf --zsh)
    export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --info=inline'
    
    # Teach FZF to use ripgrep to quickly find files (ignoring Git/hidden files)
    if command -v rg >/dev/null; then
        export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
    fi
fi
