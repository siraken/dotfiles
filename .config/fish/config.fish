# $HOME/.config/fish
set FISH_CONFIG_PATH (dirname (status --current-filename))
set fish_greeting

# Paths
command -q zoxide; and status --is-interactive; and zoxide init fish --cmd cd | source

# Functions
source $FISH_CONFIG_PATH/function.fish

# Completions
source $FISH_CONFIG_PATH/completion.fish

# OS-specific configurations
switch (uname)
    case Darwin
        source $FISH_CONFIG_PATH/config-darwin.fish
    case Linux
        source $FISH_CONFIG_PATH/config-linux.fish
end

# direnv
direnv hook fish | source

# Starship
starship init fish | source
