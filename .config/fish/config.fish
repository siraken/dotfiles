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

# GitHub Copilot CLI
source $FISH_CONFIG_PATH/config-copilot.fish

# pnpm completion
if test -f $FISH_CONFIG_PATH/pnpm.fish
  source $FISH_CONFIG_PATH/pnpm.fish
else
  command -q pnpm; and status --is-interactive; \\
  and pnpm install-completion | source
end

# OS-specific configurations
switch (uname)
  case Darwin
    source $FISH_CONFIG_PATH/config-darwin.fish
  case Linux
    source $FISH_CONFIG_PATH/config-linux.fish
end

# Starship
starship init fish | source
