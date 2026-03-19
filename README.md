# Connor's Dotfiles

## Context

This repository manages the dotfiles for Connor's development environment across three machines:
- **Home PC** — Linux Mint (Cinnamon)
- **Work machine** — Windows
- **Laptop** — macOS

It was set up to synchronize a riced development environment, and uses **Chezmoi** for cross-platform compatibility.

## Tool: Chezmoi

Dotfiles are managed with **[Chezmoi](https://chezmoi.io)**, a cross-platform dotfile manager.
Unlike Stow (which uses symlinks), Chezmoi copies files to their target locations and tracks
changes. It supports templates for machine-specific config, making it suitable for managing
differences between Linux, macOS, and Windows machines.

The Chezmoi binary is installed at `~/.local/bin/chezmoi`. Update it with:

```bash
chezmoi upgrade
```

### Source Directory

The source directory is `~/dotfiles`, configured in `~/.config/chezmoi/chezmoi.toml`:

```toml
sourceDir = "/home/connor/dotfiles"
```

## Repository Structure

Chezmoi uses a `dot_` prefix in place of a leading `.` in filenames, so the source mirrors
the home directory structure directly:

```
~/dotfiles/
├── dot_bashrc                              → ~/.bashrc
├── dot_profile                             → ~/.profile
├── dot_gitconfig                           → ~/.gitconfig
├── dot_conkyrc                             → ~/.conkyrc
├── dot_config/
│   ├── ghostty/
│   │   └── empty_config.ghostty           → ~/.config/ghostty/config.ghostty
│   └── Code/User/
│       └── settings.json                  → ~/.config/Code/User/settings.json
├── .chezmoiignore                          — files chezmoi should not manage
└── README.md                              — this file (not deployed to ~)
```

The `empty_` prefix on the ghostty config tells Chezmoi to create the file even though it is
currently empty (a placeholder for future configuration).

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
# 1. Install chezmoi (no sudo required)
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin

# 2. Clone the repo
git clone <remote-url> ~/dotfiles

# 3. Create chezmoi config pointing at the repo
mkdir -p ~/.config/chezmoi
echo 'sourceDir = "/home/connor/dotfiles"' > ~/.config/chezmoi/chezmoi.toml

# 4. Apply
chezmoi apply

# 5. Set up machine-local config (e.g. git work email)
# Create ~/.gitconfig-work manually
```

## Theme

The environment uses the **Catppuccin Mocha** colour scheme consistently across:
- VSCode (Catppuccin Mocha theme + icon theme)
- Conky (Catppuccin Mocha palette)
- Terminal: Ghostty
- Prompt: Starship
