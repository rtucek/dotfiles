# Setup fzf
# ---------
if [[ ! "$PATH" == */home/rtucek/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/rtucek/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/rtucek/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/rtucek/.fzf/shell/key-bindings.bash"
