# Set up the prompt

# enable colors, change prompt
autoload -U colors && colors
PS1="%B%{$fg[blue]%}%~%{$fg[white]%}  ﰲ %b"

setopt autocd

# emacs keybinds
bindkey -e

# history settings
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# source files
aliasrc=$HOME/.config/aliasrc
defaultsrc=$HOME/.config/defaultsrc
pathrc=$HOME/.config/pathrc

[ -f $aliasrc ] && source $aliasrc
[ -f $defaultsrc ] && source $defaultsrc
[ -f $pathrc ] && source $pathrc

#source "$HOME/.cargo/env"

# autocomplete
autoload -U compinit
zstyle ':completion:*' menu select
compinit
_comp_options+=(globdots)				# include hidden files 


export SHELL=/bin/zsh
export EDITOR=$(which nvim)
export MANPAGER="nvim -c 'set ft=man'"

export DOTNET_CLI_TELEMETRY_OPTOUT=1

# vi mode
bindkey -v
export KEYTIMEOUT=300

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
bindkey -M viins 'jk' vi-cmd-mode

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

fsh_path=$HOME/.config/zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
[ -f $fsh_path ] && source $fsh_path 2>/dev/null

# colors upon entering st
#[ "$TERM" != "linux" ] && [ "$TERM_PROGRAM" != "vscode" ] && ()


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/aleks/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/aleks/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/aleks/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/aleks/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

