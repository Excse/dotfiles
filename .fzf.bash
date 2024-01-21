# Setup fzf
# ---------
if [[ ! "$PATH" == */home/timo/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/timo/.fzf/bin"
fi

# Auto-completion
# ---------------
source "/home/timo/.fzf/shell/completion.bash"

# Key bindings
# ------------
source "/home/timo/.fzf/shell/key-bindings.bash"
