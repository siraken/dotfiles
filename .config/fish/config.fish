set fish_greeting

# Aliases
alias vi="nvim"
alias vim="nvim"

# Functions
# source (dirname (status --current-filename))/f.fish
# source (dirname (status --current-filename))/fisher-install.fish

# Path
status --is-interactive; and rbenv init - fish | source

# OS-specific config
switch (uname)
  case Darwin
    source (dirname (status --current-filename))/config-darwin.fish
  case Linux
    source (dirname (status --current-filename))/config-linux.fish
end

# Starship
# starship init fish | source
