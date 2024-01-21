# Setup fzf
# ---------
if [[ ! "$PATH" == */home/timo/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/timo/.fzf/bin"
fi

# Auto-completion
# ---------------
source "/home/timo/.fzf/shell/completion.zsh"

# Key bindings
# ------------
source "/home/timo/.fzf/shell/key-bindings.zsh"
