# $HOME/.config/fish
set FISH_CONFIG_PATH (dirname (status --current-filename))

# Common functions
source $FISH_CONFIG_PATH/common.fish

# Paths
source $FISH_CONFIG_PATH/path.fish

# Variables
source $FISH_CONFIG_PATH/variable.fish

# Functions
source $FISH_CONFIG_PATH/function.fish

# Aliases
source $FISH_CONFIG_PATH/alias.fish

# asdf
source $FISH_CONFIG_PATH/asdf

# GitHub Copilot CLI
source $FISH_CONFIG_PATH/config-copilot.fish

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
