# Connor's Dotfiles

## Context

This repository manages the dotfiles for Connor's Linux Mint (Cinnamon) programming workstation.
It was set up to synchronize a riced development environment between two machines: a home PC and a work laptop.

## Tool: GNU Stow

Dotfiles are managed with **GNU Stow**, a symlink farm manager. Each top-level directory in this
repo is a "package". Running `stow <package>` from inside `~/dotfiles/` creates symlinks in the
home directory (`~`) that point back into this repo.

**Why this direction?** Programs look for config files at fixed paths (e.g. `~/.bashrc`). The real
file must live in the repo so git can track it, while the original path resolves via symlink so
programs can still find it.

## Repository Structure

```
~/dotfiles/
├── bash/
│   ├── .bashrc           → ~/.bashrc
│   └── .profile          → ~/.profile
├── git/
│   └── .gitconfig        → ~/.gitconfig
├── conky/
│   └── .conkyrc          → ~/.conkyrc
├── ghostty/
│   └── .config/ghostty/
│       └── config.ghostty → ~/.config/ghostty/config.ghostty
└── vscode/
    └── .config/Code/User/
        └── settings.json  → ~/.config/Code/User/settings.json
```

Planned future packages:
- `nvim/` — Neovim config at `~/.config/nvim/` (not yet configured)

## Machine-Specific Config

Some settings differ between machines (e.g. git email for work vs. personal).
These are handled via **git conditional includes** rather than being tracked here.

In `~/.gitconfig`, add:

```ini
[includeIf "gitdir:~/Documents/work/"]
    path = ~/.gitconfig-work
```

`~/.gitconfig-work` is kept local on each machine and is intentionally not tracked in this repo.

## What Is Not Tracked

- `~/.gtkrc-2.0` — auto-generated and overwritten by Cinnamon settings
- `~/.config/gtk-3.0/gtk.css` — empty, managed by Cinnamon
- `~/.gnupg/` — GPG keys, never commit
- `~/.ssh/` — SSH keys, never commit
- `~/.claude.json` — Claude Code session state
- `~/.boto` — Google Cloud credentials
- `dconf` — Cinnamon/GNOME settings database; back up separately with `dconf dump /`

## Setting Up a New Machine

```bash
# 1. Install stow
sudo apt install stow

# 2. Clone the repo
git clone <remote-url> ~/dotfiles

# 3. Remove any conflicting default files (e.g. ~/.bashrc)
rm ~/.bashrc ~/.profile  # etc.

# 4. Stow each package
cd ~/dotfiles
stow bash git conky ghostty vscode

# 5. Set up machine-local config
cp ~/.gitconfig-work.example ~/.gitconfig-work  # if applicable
```

## Theme

The environment uses the **Catppuccin Mocha** colour scheme consistently across:
- VSCode (Catppuccin Mocha theme + icon theme)
- Conky (Catppuccin Mocha palette)
- Terminal: Ghostty
- Prompt: Starship
