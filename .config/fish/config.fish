# Common functions
source (dirname (status --current-filename))/common.fish

# Aliases
source (dirname (status --current-filename))/alias.fish

# Paths
source (dirname (status --current-filename))/path.fish

# Variables
source (dirname (status --current-filename))/variable.fish

# Functions
source (dirname (status --current-filename))/function.fish

# GitHub Copilot CLI
source (dirname (status --current-filename))/config-copilot.fish

# OS-specific configurations
switch (uname)
  case Darwin
    source (dirname (status --current-filename))/config-darwin.fish
  case Linux
    source (dirname (status --current-filename))/config-linux.fish
end

# Starship
# starship init fish | source
