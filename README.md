# dotfiles (chezmoi)

This repository contains personal dotfiles managed with chezmoi. It enables quick bootstrap and consistent configuration of shells and tooling across machines (Linux/WSL).
The configuration targets zsh with oh-my-zsh and Powerlevel10k, plus some bash and git settings. A small MOTD script prints a colorful banner and system info.

## Overview

- Manager: chezmoi (applies files into $HOME)
- Shell focus: zsh (oh-my-zsh, plugins, Powerlevel10k), with bash support
- Extras: custom MOTD banner script, git configuration, environment variables for common tools

## Stack

- Languages: shell scripts (sh, bash, zsh)
- Tools/frameworks: chezmoi, oh-my-zsh, Powerlevel10k, common zsh plugins (syntax-highlighting, autosuggestions, completions, you-should-use)
- Package managers touched:
  - apt (in an install script; assumes Debian/Ubuntu or WSL Debian/Ubuntu)
  - git (used to fetch themes/plugins)
  - nvm and cargo are sourced if present (not installed by this repo)
- Chezmoi hooks: run_once_*.tmpl script included

## Requirements

Minimum to apply the configuration:
- chezmoi
- git
- Debian/Ubuntu

Recommended/optional for best experience:
- A Nerd Font in your terminal (for Powerlevel10k symbols)
- nvm (Node Version Manager) if you use Node.js
- Rust toolchain (cargo) if you use Rust
- gpg (for git commit/tag signing as configured)

If you already have chezmoi installed:

```sh
chezmoi init --apply Excse
```

If not, install chezmoi and apply in one command:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply Excse
```

## Updating / applying changes

Fetch and apply latest updates:

```sh
chezmoi update
```

Apply local changes after editing tracked files:

```sh
chezmoi apply
```

## Editing workflow

Open a tracked file for editing (writes into the source state in this repo):

```sh
chezmoi edit <file>
```

Then apply it:

```sh
chezmoi apply
```

## Scripts and hooks

- run_once_install-script.sh.tmpl
  - Runs once on first apply. Installs zsh, figlet, lolcat via apt when missing.
  - Installs oh-my-zsh and common zsh extras into $ZSH_CUSTOM (~/.oh-my-zsh/custom):
    - Powerlevel10k theme
    - zsh-autosuggestions
    - zsh-syntax-highlighting
    - zsh-completions
    - you-should-use
  - Requirements: curl, git, zsh
- executable_dot_motd
  - Bash program that prints a banner and system info (date, CPU load, memory, disk, sessions, battery if available).
  - Uses: figlet, lolcat, tput, free, df, who, upower (optional).
  - dot_zshrc integrates it and overrides the clear command to show a short banner when clearing the screen.

## Usage tips

- After first apply, start a new zsh session to load oh-my-zsh and plugins.
- Ensure your terminal uses a Nerd Font for Powerlevel10k symbols.
- If MOTD colors/banners are not desired, remove or edit executable_dot_motd and the clear() function in dot_zshrc.


## License
This project is licensed under the BSD 3-Clause License. See the [LICENSE](LICENSE) file for details.