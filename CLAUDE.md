# Dotfiles (chezmoi)

This repo is public: file content, filenames, commit messages, author metadata and history
are all world-readable. Treat every commit as published.

## Keep it neutral

Committed text carries hooks, never work-specific values. Employer and client names, work
emails and usernames, internal hostnames, URLs and paths, SSH key filenames, tokens and
1Password item names all live outside the repo. This covers code, comments, commit messages,
branch names, PR text and doc examples. Where a name would help, write "work" or "dev profile".

Values live in unmanaged local files that chezmoi never sees:

* `~/.ssh/config.local`: extra SSH hosts and keys.
* `~/.config/zsh/local.zsh`: extra aliases, functions, env vars.
* `~/.config/chezmoi/chezmoi.toml` `[data]`: per-machine values (profile, `work_emails`).
  Templates read them as chezmoi data.

A change that needs a new work-specific value adds the hook (an include, a sourced file or a
data key) and puts the value in the matching local file.

## Commit gate

Before every commit, scan the staged change and the drafted message against the local
denylist, one term per line, kept at `~/.config/dotfiles/denylist.txt`:

```sh
{ git diff --cached --name-only; git diff --cached -U0; } | grep -i -n -f ~/.config/dotfiles/denylist.txt
printf '%s' "$MSG" | grep -i -f ~/.config/dotfiles/denylist.txt
```

The gate is done when both scans print nothing. A hit blocks the commit: report it and let
the user decide. If the denylist file is missing, ask for it before committing.

The denylist stays local. Its terms never appear in the repo, including in docs that explain
the rule.

Commit only when asked: one change per commit, short message. Pushing, force-pushing and
changing repo visibility each need explicit approval.

## Already pushed

Treat the value as exposed: tell the user, who rotates any secret. Removing it from history
means a rewrite, which waits for the user's request.

## chezmoi gotchas

* A root-level file that is not a dotfile (docs, scripts) is listed in `.chezmoiignore`, or
  chezmoi applies it to `$HOME`.
* `README.md` follows any change to profiles, local override files or bootstrap steps.
