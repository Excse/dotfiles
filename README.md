# dotfiles (chezmoi)

This repository contains personal dotfiles managed with [chezmoi](https://www.chezmoi.io/). It enables quick bootstrap and consistent configuration of shells and tooling across machines (Linux/WSL).

The configuration primarily targets zsh with oh-my-zsh and Powerlevel10k, plus some bash and git settings.

## Overview

- Manager: chezmoi (applies files into $HOME)
- Shell focus: zsh (oh-my-zsh, plugins, Powerlevel10k), with bash support
- Extras: custom MOTD banner script, git configuration, environment variables for common tools

## Tech stack / detection

- Languages: shell scripts (sh, bash, zsh)
- Frameworks/tools: chezmoi, oh-my-zsh, Powerlevel10k, zsh plugins (syntax-highlighting, autosuggestions, completions, you-should-use)
- Package managers used by environment (not by this repo directly): git; nvm (sourced if installed); cargo (sourced if installed)
- Templates/hooks: chezmoi's run_once_*.tmpl and run_onchange_*.tmpl scripts

## Requirements

Minimum to apply the configuration:
- chezmoi
- git (needed by chezmoi and plugin installation scripts)
- zsh (for zsh-specific configuration)
- curl (used by the oh-my-zsh installer)

Recommended/optional for best experience:
- Powerlevel10k font setup (Nerd Fonts) in your terminal
- figlet and lolcat (for the MOTD script banner)
- nvm (Node Version Manager) if you use Node.js
- Rust toolchain (cargo) if you use Rust
- gpg (for git commit/tag signing as configured)

## Quick setup

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

The following chezmoi scripts are provided:

- run_once_install-oh-my-zsh.sh.tmpl
  - Runs once on first apply. Installs oh-my-zsh via the official install script.
  - Respects existing ~/.zshrc (KEEP_ZSHRC=yes) and prevents auto-launch during install (RUNZSH=no).
  - Requires: zsh, curl.

- run_onchange-install-zsh-plugins.sh.tmpl
  - Runs whenever the script changes. Installs common zsh extras into $ZSH_CUSTOM (defaults to ~/.oh-my-zsh/custom):
    - Powerlevel10k theme
    - zsh-autosuggestions
    - zsh-syntax-highlighting
    - zsh-completions
    - you-should-use
  - Requires: git, zsh.

- executable_dot_motd
  - A small Bash program that prints a colorful message-of-the-day with system info.
  - Uses figlet, lolcat, tput, free, df, who.
  - dot_zshrc integrates it and overrides the clear command to show a short banner when clearing the screen.

ChezMoi note: Files without a leading dot are mapped into $HOME with a dot (e.g., dot_zshrc -> ~/.zshrc). Files with special prefixes like run_once_ and run_onchange_ are executed by chezmoi as hooks.

## Environment variables and paths

Key environment/customization in shell configs:

- dot_zshrc
  - PATH includes: ~/.local/bin, /opt/nvim, ~/opt/cross/bin
  - ZSH=$HOME/.oh-my-zsh; theme: powerlevel10k/powerlevel10k
  - Plugins: git, zsh-syntax-highlighting, zsh-autosuggestions, zsh-completions, you-should-use
  - NVM_DIR=$HOME/.nvm (sources nvm if present)
  - Cargo environment sourced from $HOME/.cargo/env
  - GPG_TTY=$TTY
  - Custom clear() function shows ~/.motd output
  - Sources ~/.p10k.zsh if present

- dot_zshenv
  - Sources $HOME/.cargo/env
  - Adds argcomplete completions path to fpath (path is user/machine specific; consider adjusting for your system)

- dot_bashrc
  - Standard Debian-ish bash defaults plus:
  - NVM_DIR ($HOME/.nvm) with nvm and its bash_completion
  - Sources $HOME/.cargo/env
  - GPG_TTY=$(tty)

- dot_gitconfig
  - Sets user name/email and enables GPG signing for commits/tags
  - pull.rebase=true
  - If you fork this repo, update your identity and signing key

## Project structure

- README.md — this document
- dot_bashrc — mapped to ~/.bashrc
- dot_gitconfig — mapped to ~/.gitconfig
- dot_p10k.zsh — mapped to ~/.p10k.zsh (Powerlevel10k config)
- dot_zshenv — mapped to ~/.zshenv
- dot_zshrc — mapped to ~/.zshrc
- executable_dot_motd — mapped to ~/.motd and made executable
- run_once_install-oh-my-zsh.sh.tmpl — installs oh-my-zsh on first apply
- run_onchange-install-zsh-plugins.sh.tmpl — installs/updates common zsh plugins when this script changes

## Usage tips

- After first apply, start a new zsh session to load oh-my-zsh and plugins.
- Ensure your terminal uses a Nerd Font for Powerlevel10k symbols.
- If MOTD colors/banners are not desired, remove or edit executable_dot_motd and the clear() function in dot_zshrc.

## Tests

- There are no automated tests in this repository. Manual verification steps:
  - Run chezmoi apply and confirm zsh starts with Powerlevel10k
  - Verify plugins are present in ~/.oh-my-zsh/custom
  - Confirm ~/.motd renders without errors (install figlet/lolcat if missing)

## License

- No explicit license is currently included. TODO: Add a LICENSE file if you intend to share or open-source these dotfiles.

## Maintenance

- To pull upstream changes to this repo into a machine, use:

```sh
chezmoi update
```

- To edit machine-specific secrets or private data, consult chezmoi templates and encrypted data docs. TODO: Document any templates or private data if/when added.
