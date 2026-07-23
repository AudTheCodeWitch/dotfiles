# 👩‍💻 Audrea's macOS Dotfiles

Setting up a new machine sucks. I hate it, so I've taken the time to set up these
dotfiles, which are managed via [chezmoi](https://www.chezmoi.io/). Future me:
you're welcome. Keep this up to date, or you'll regret it!

---

## 🛠️ Tech Stack & Key Components

| Category | Tools | Description |
| :--- | :--- | :--- |
| **Shell** | `Zsh` + `Oh My Zsh` | The backbone shell, clean and modularized. |
| **Runtimes** | `mise` | Fast, shimless polyglot version manager (Ruby, Node). |
| **Terminal** | `Ghostty` | Fast, GPU-accelerated, modern terminal emulator. |
| **Editor** | `Helix` (`hx`) | Modern modal editor with built-in LSP support (`$EDITOR`). |
| **Git Engine** | `git-delta` | Modern, syntax-highlighted side-by-side diffs. |
| **Security** | `1Password` | Cryptographic Git commit signing & SSH agent integration. |

---

## 📂 Dotfile Anatomy

The repository is modularly structured to enforce clean separation of concerns:

```text
.local/share/chezmoi/
├── private_dot_config/
│   ├── ghostty/
│   │   └── config            # Terminal layout, theme, & shortcuts
│   ├── helix/
│   │   └── config.toml       # Line numbers, LSP, mouse support
│   ├── homebrew/
│   │   └── Brewfile          # Universal package manifest (apps, CLI, casks)
│   └── zsh/
│       ├── aliases.zsh       # Shorthand Git, Rails, & system shortcuts
│       └── tools.zsh         # Modern Rust tools & runtime hooks (mise, zoxide)
├── dot_gitconfig             # Git settings, 1Password signing, Delta config
├── dot_gitignore             # Global project ignore rules
└── dot_zshrc                 # System environment, pathing, & plugin loader
```

---

## 🚀 Fast Bootstrap (New Machine Setup)

To replicate this exact environment on a brand-new Mac:

### Step 1: Run the One-Liner Engine
```zsh
sh -c "$(curl -fsLS [https://get.chezmoi.io](https://get.chezmoi.io))" -- init --apply audthecodewitch
```
> **What this does:** Installs Homebrew, fetches CLI packages via `Brewfile`, sets up `mise`, clones custom Zsh plugins, and links all dotfiles.

### Step 2: Authenticate 1Password
Open 1Password from `Applications`, sign into your account, and enable:
* **Settings → Developer → Use 1Password SSH Agent**
* **Settings → Developer → Integrate with 1Password CLI**

### Step 3: Sync & Reload Shell
```zsh
chezmoi apply && exec zsh
```

---

## 🏎️ Everyday Dotfile Workflow

### Editing Configurations
* **Edit file:** `chezmoi edit <path-in-home>` (e.g., `chezmoi edit ~/.zshrc`)
* **Inspect drift:** `chezmoi diff`
* **Apply live:** `chezmoi apply`
* **Check status:** `chezmoi status`

### Syncing to Remote Repository
```zsh
cd $(chezmoi source-path)
git add .
git commit -m "feat: update system configurations"
git push origin main
```

---

## 🏎️ Elite Shortcuts Cheat Sheet

### Modern CLI Upgrades
* `ls` / `ll` - Displays directory listings with Git status integration via `eza`.
* `cat [file]` - Syntax-highlights files in terminal via `bat`.
* `df` - Visual disk usage statistics via `duf`.
* `z [dir]` - Teleports to frequently visited folders via `zoxide`.
* `Ctrl + R` - Triggers a visual fuzzy-search interface for history via `fzf`.

### Development Gateway
* `g` - Universal gateway to custom `.gitconfig` aliases.
	* `g st` - Highly condensed, clean Git status.
	* `g lg` - Graphical commit tree.
	* `g oops` - Amends staged edits into last commit without prompt.
* `be` - `bundle exec`
* `rc` - `bundle exec rails console`
* `dbm` - `bundle exec rails db:migrate`
* `dev` - Spins up modern `bin/dev` or Overmind tasks cleanly.
* `lzd` - Launches visual terminal manager for Docker via `lazydocker`.
