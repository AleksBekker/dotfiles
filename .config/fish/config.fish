# Fish shell configuration

# Enable vi mode
fish_vi_key_bindings

# Map 'jk' to escape in insert mode
bind -M insert jk 'set fish_bind_mode default; commandline -f repaint'

# Cursor shape for different vi modes
# Block cursor for normal mode, beam for insert mode
function fish_vi_cursor --on-variable fish_bind_mode
    switch $fish_bind_mode
        case default
            echo -ne '\e[1 q'  # block
        case insert
            echo -ne '\e[5 q'  # beam
        case replace_one
            echo -ne '\e[3 q'  # underline
        case visual
            echo -ne '\e[1 q'  # block
    end
end

# Set beam cursor on startup
echo -ne '\e[5 q'

# History settings
set -g fish_history_max 10000

set -U fish_greeting
