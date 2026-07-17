# ==============================================================================
# 💎 SHORTHAND ALIASES & DEV SHORTCUTS
# ==============================================================================

# General Utilities
alias reload="exec zsh"                 # Instantly reload your terminal environment

# Git Gateway (Triggers your custom .gitconfig aliases!)
alias g="git"

# Ruby on Rails Developer Kit
alias be="bundle exec"                  # Context-safe command executor
alias rc="bundle exec rails console"    # Launch interactive Rails console
alias dbm="bundle exec rails db:migrate" # Run pending database migrations
alias dev="overmind start"              # Spin up modern bin/dev tasks cleanly
alias guard="bundle exec guard"         # Ruby Guard

# Container Management
alias lzd="lazydocker"                  # Terminal visual UI for Docker/Rancher
alias k="kubectl"                       # Standard Kubernetes shorthand
