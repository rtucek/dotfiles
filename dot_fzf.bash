# Setup fzf
# ---------
if [[ ! "$PATH" == */home/rtucek/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/rtucek/.fzf/bin"
fi

eval "$(fzf --bash)"
