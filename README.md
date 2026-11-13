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
│   │   ├── Brewfile          # Universal package manifest (apps, CLI, casks)
│   │   └── Brewfile.dev      # Extra packages for the dev profile
│   └── zsh/
│       ├── aliases.zsh       # Shorthand Git, Rails, & system shortcuts
│       └── tools.zsh         # Modern Rust tools & runtime hooks (mise, zoxide)
├── dot_gitconfig             # Git settings, 1Password signing, Delta config
├── dot_gitignore             # Global project ignore rules
└── dot_zshrc.tmpl            # System environment, pathing, & plugin loader
```

---

## 🧩 Profiles & Local Overrides

`chezmoi init` asks for a machine profile once and stores it in `~/.config/chezmoi/chezmoi.toml`.

| Profile | Applies |
| :--- | :--- |
| `base` | `Brewfile` only. |
| `dev` | `Brewfile` and `Brewfile.dev`, plus `JAVA_HOME` in `.zshrc`. |

Init also asks for extra git signer emails (comma-separated, blank for none). They stay in the
local chezmoi config and never enter this repo.

Settings that belong to one machine live in files chezmoi does not manage:

* `~/.ssh/config.local`: extra SSH hosts and keys, included from `~/.ssh/config`.
* `~/.config/zsh/local.zsh`: extra aliases and functions, sourced at the end of `~/.zshrc`.

### Local file backup (1Password)

These files are not in the repo, so each one lives in 1Password as a Document item (Private
vault). Back up, or refresh after an edit, with the [1Password CLI](https://developer.1password.com/docs/cli/):

| File | 1Password item |
| :--- | :--- |
| `~/.ssh/config.local` | `dotfiles-local-ssh-config` |
| `~/.config/zsh/local.zsh` | `dotfiles-local-zsh` |
| `~/.config/dotfiles/denylist.txt` | `dotfiles-local-denylist` |
| `[data]` block of `~/.config/chezmoi/chezmoi.toml` (`work_emails` etc.) | `dotfiles-local-chezmoi-data` |

```zsh
op document create ~/.ssh/config.local --title dotfiles-local-ssh-config
# Refresh an existing item instead: op document edit dotfiles-local-ssh-config ~/.ssh/config.local
```

Restore on a new machine: see Step 3 of the bootstrap below.

---

## 🔒 Keeping Private Details Out

This repo is public. Don't commit employer or client names, work emails, internal hostnames
or paths, SSH key filenames, or tokens. That covers file content, commit messages, branch
names and author metadata.

* Put anything machine- or employer-specific in the local override files above, or in the
  `[data]` block of `~/.config/chezmoi/chezmoi.toml`. Templates read it from there.
* Optional: keep a local list of terms to block, one per line, in
  `~/.config/dotfiles/denylist.txt` (never committed), then check before committing:
  ```zsh
  git diff --cached -U0 | grep -i -n -f ~/.config/dotfiles/denylist.txt
  ```
* `CLAUDE.md` holds the same rules for Claude Code sessions in this repo.
* If something sensitive does get pushed, treat it as exposed: rotate any secret, then
  rewrite history. Deleting the file in a later commit is not enough.

---

## 🚀 Fast Bootstrap (New Machine Setup)

To replicate this exact environment on a brand-new Mac:

### Step 1: Run the One-Liner Engine
```zsh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply AudTheCodeWitch
```

This will:
- Install Homebrew
- Fetch CLI packages via `Brewfile`
- Set up `mise` for Ruby & Node version management
- Clone custom Zsh plugins
- Link all dotfiles to your home directory

### Step 2: Authenticate 1Password
Open 1Password from `Applications`, sign into your account, and enable:
* **Settings → Developer → Use 1Password SSH Agent**
* **Settings → Developer → Integrate with 1Password CLI**

### Step 3: Restore Local Files
This step needs the `op` CLI and the Step 2 sign-in with **Integrate with 1Password CLI** on.
The `dev` profile installs `op` (via `Brewfile.dev`). On `base`, install it first:
`brew install --cask 1password-cli`.

Then pull the files that are not in the repo
(see [Local file backup](#local-file-backup-1password)):
```zsh
mkdir -p ~/.config/zsh ~/.config/dotfiles
op document get dotfiles-local-ssh-config --out-file ~/.ssh/config.local
op document get dotfiles-local-zsh --out-file ~/.config/zsh/local.zsh
op document get dotfiles-local-denylist --out-file ~/.config/dotfiles/denylist.txt
op document get dotfiles-local-chezmoi-data   # copy the values into the `chezmoi init` prompts
```
`chezmoi init` does not re-ask questions it already answered. If it ran with blank answers,
run `chezmoi init --prompt` to answer them again.
Files restored with `--out-file` get mode `0600`, which SSH requires.

### Step 4: Sync & Reload Shell
```zsh
eval "$(/opt/homebrew/bin/brew shellenv)" && chezmoi apply && exec zsh
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

## 🏎️ Alias Cheat Sheet

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
