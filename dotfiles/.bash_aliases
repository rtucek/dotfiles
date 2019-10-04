# override some default commands
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less

# some more ls aliases
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# grep aliases
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

# diff color alias
alias diff='diff --color=auto'

# Mock pbcopy and pbpaste
alias pbcopy='xclip -selection c'
alias pbpaste='xclip -selection clipboard -o'
