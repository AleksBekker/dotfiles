# enable colors, change prompt
autoload -U colors && colors
PS1="%B%{$fg[blue]%}%~%{$fg[white]%}  ﰲ %b"

source $HOME/.local/share/zsh/powerlevel10k/powerlevel10k.zsh-theme

# if [[ -r "${HOME}/.local/share/zsh/powerlevel10k/" ]]

setopt autocd

# emacs keybinds
bindkey -e

# history settings
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh_history

# source files
aliasrc=$HOME/.config/aliasrc
defaultsrc=$HOME/.config/defaultsrc
pathrc=$HOME/.config/pathrc
keyrc=$HOME/.config/keyrc

[ -f $aliasrc ] && source $aliasrc
[ -f $defaultsrc ] && source $defaultsrc
[ -f $pathrc ] && source $pathrc
[ -f $keyrc ] && source $keyrc

# autocomplete
autoload -U compinit
zstyle ':completion:*' menu select
compinit
_comp_options+=(globdots)				# include hidden files 


export SHELL=/bin/zsh
export EDITOR=$(which nvim)
export MANPAGER="nvim +Man!"

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

source ~/.local/share/zsh/fsh/fast-syntax-highlighting.plugin.zsh

# [ "$TERM" != "linux" ] && \
#     [ "$TERM" != "xterm-256color" ] && \
#     [ "$TERM_PROGRAM" != "vscode" ] && \
#     ufetch

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
