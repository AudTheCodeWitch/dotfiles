# 👩‍💻 Audrea's macOS Dotfiles

Setting up a new machine sucks. I hate it, so I've taken the time to set up these
dotfiles, which are managed via [chezmoi](https://www.chezmoi.io/). Future me:
you're welcome.

---

## 🛠️ Tech Stack & Key Components

| Category | Tools | Description |
| :--- | :--- | :--- |
| **Shell** | `Zsh` + `Oh My Zsh` | The backbone shell, clean and error-free. |
| **Terminal** | `Ghostty` | Fast, GPU-accelerated, modern terminal emulator. |
| **Editor** | `Helix` (`hx`) | Modern modal editor with built-in LSP support. |
| **Git Engine** | `git-delta` | Modern, syntax-highlighted side-by-side diffs. |
| **Security** | `1Password` | Cryptographic Git commit signing via SSH keys. |

---

## 📂 Dotfile Anatomy

The repository is modularly structured to enforce clean separation of concerns:

```text
.local/share/chezmoi/
├── private_dot_config/
│   ├── ghostty/
│   │   └── config            # Terminal layout & shortcuts
│   ├── helix/
│   │   └── config.toml       # Relative lines, mouse support, One Dark theme
│   ├── homebrew/
│   │   └── Brewfile          # Universal package list (apps, CLI, casks)
│   └── zsh/
│       ├── aliases.zsh       # Pure Git, Rails, and system typing shortcuts
│       └── tools.zsh         # Rust replacement engines & tool hook-ups
├── dot_gitconfig             # Git settings, 1Password signing, Delta config
├── dot_gitignore             # Global project ignore file
└── dot_zshrc                 # System environment, pathing, & plugin loader
```

---

## 🚀 Fast Bootstrap (New Machine Setup)

To replicate this exact environment on a brand-new Mac:

### Step 1: Install Chezmoi and initialize the dotfiles
```zsh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply <your-github-username>
```

### Step 2: Run the Homebrew bundle to install all applications
```zsh
brew bundle --global
```

### Step 3: Install Oh My Zsh
```zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Step 4: Install Custom Zsh Plugins (isolated in ~/.config/zsh)
```zsh
mkdir -p ~/.config/zsh/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.config/zsh/plugins/zsh-syntax-highlighting
git clone https://github.com/fdellwing/zsh-bat.git ~/.config/zsh/plugins/zsh-bat
```

### Step 5: Sync everything live
```zsh
chezmoi apply && exec zsh
```

---

## 🏎️ Elite Shortcuts Cheat Sheet

### Modern CLI Upgrades
* `ll` - Displays beautiful, directory listings with Git status integration via `eza`.
* `cat [file]` - Syntax-highlights files in the terminal via `bat`.
* `df` - Beautiful visual disk usage mapping via `duf`.
* `z [dir]` - Teleports instantly to any frequently visited folder via `zoxide`'s learning engine.
* `Ctrl + R` - Triggers a visual, fuzzy-searchable interface for shell history via `fzf`.

### Development Gateway
* `g` - The universal gateway to your advanced `.gitconfig` aliases.
	* `g st` - Highly condensed, clean Git status.
	* `g lg` - Stunning colorful graphical commit tree.
	* `g oops` - Instantly amends staged edits to your last commit without changing the message.
* `be` - `bundle exec`
* `rc` - `bundle exec rails console`
* `dbm` - `bundle exec rails db:migrate`
* `dev` - boots up process-management via `overmind`.
* `lzd` - launches a visual terminal manager for docker containers via `lazydocker`.
```
