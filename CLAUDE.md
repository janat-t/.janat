# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository (`~/.janat`). It stores shell configs, editor configs, git configs, and aliases for multiple environments. The primary setup mechanism is symlinking files from this repo into `~`.

## Setup

**Install symlinks** (run from anywhere):
```sh
~/.janat/scripts/link.sh [mode]
```

Modes:
- `zsh` (default) — personal macOS zsh setup
- `ubuntu` — personal Ubuntu zsh setup
- `bash` — personal bash setup
- `indeed` / `indeed-zsh` — work zsh setup
- `cvm` / `indeed-bash` — work bash setup (CVM)

The script backs up any existing configs (`.old` suffix), then symlinks the appropriate files.

**Install oh-my-zsh and plugins** (first-time setup):
```sh
~/.janat/scripts/install_oh_my_zsh.sh
```

**Install other tools** (macOS only):
```sh
~/.janat/scripts/install_other.sh
```

## Architecture

### Environment profiles

Each environment has a paired shell config + git config:

| Mode | Shell config | Git config |
|------|-------------|------------|
| zsh (personal) | `zshrc.zsh` | `gitconfig.cfg` |
| zsh (ubuntu) | `zshrc.ubuntu.zsh` | `gitconfig.cfg` |
| zsh (indeed) | `zshrc.indeed.zsh` | `gitconfig.indeed.cfg` |
| bash (indeed/CVM) | `bashrc.cvm.bash` | `gitconfig.cvm.cfg` |

`zshrc.ubuntu.zsh` adds `LC_ALL`/`LC_CTYPE`, NVM, and a `.local/bin/env` source on top of the macOS base.

### Aliases

Aliases are split into topic files sourced dynamically by `zshrc`/`bashrc`:

- `alias.dir.sh` — directory navigation shortcuts
- `alias.git.sh` — comprehensive git aliases + helper functions (`git_current_branch`, `git_main_branch`, `gacp`)
- `alias.util.sh` — general utilities (compilers, python, tmux, terraform, etc.)
- `alias.pic.sh` — image/media related
- `templates/.alias` — template utilities (`cftmp` for competitive programming)

### Editor config

- `vim/vimrc` — vim config using vim-plug; plugins live in `vim/plugged/`
- `nvim/init.vim` — neovim config (symlinked to `~/.config/nvim`)
- Both are symlinked by `link.sh`; vim-plug install runs automatically during setup

### bin/

Custom executables on `$PATH` (`~/.janat/bin` is prepended):
- `imgcat` — display images in terminal
- `chrome` — launch Chrome
- `karabiner_cli` — Karabiner-Elements CLI wrapper
- `run-as-cron` — run a command in a cron-like environment

### p10k configs

- `p10k.zsh` — Powerlevel10k prompt config (macOS)
- `p10k.ubuntu.zsh` — Powerlevel10k prompt config (Ubuntu)
