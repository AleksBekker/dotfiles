# enable colors, change prompt
autoload -U colors && colors
PS1="%B%{$fg[blue]%}%~%{$fg[white]%}  ﰲ %b"

# setopt autocd

# emacs keybinds
bindkey -e

# history settings
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh_history

# source files
sources=("$HOME/.config/aliasrc" "$HOME/.config/defaultsrc" "$HOME/.config/pathrc" "$HOME/.config/keyrc"
"$HOME/.config/projectsrc")

for source in $sources;
do [ -f $source ] && source $source;
done

# autocomplete
autoload -U compinit
zstyle ':completion:*' menu select
compinit
_comp_options+=(globdots)				# include hidden files 

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

eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/catppuccin-mocha.json)"
source ~/.local/share/zsh/fsh/fast-syntax-highlighting.plugin.zsh

# [ "$TERM" != "linux" ] && \
#     [ "$TERM" != "xterm-256color" ] && \
#     [ "$TERM_PROGRAM" != "vscode" ] && \
#     ufetch

# Set QT theme selector to qt5ct
export QT_QPA_PLATFORMTHEME=qt5ct
