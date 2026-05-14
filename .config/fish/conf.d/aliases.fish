# Shell aliases

# TODO: Create a more robust alias system that detects GNU ls vs BSD ls
# and sets the appropriate flags accordingly (--color for GNU, -G for BSD)
alias ls "ls --color"
alias l "ls -CF --color"
alias la "ls -ACF --color"
alias ll "ls -hlF --color"
alias lal "ls -hlAF --color"

alias grep "grep --color"

if test -x "gdu-go"
    alias gdu "gdu-go"
end
