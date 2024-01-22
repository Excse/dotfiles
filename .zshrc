if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH=$HOME/.oh-my-zsh

plugins=(
  git
  tmux
  colorize
	colored-man-pages
  z
)

source $ZSH/oh-my-zsh.sh
