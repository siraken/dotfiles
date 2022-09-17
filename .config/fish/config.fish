set fish_greeting

# Aliases
alias vi="nvim"
alias vim="nvim"

# Install fisher and its plugins
source (dirname (status --current-filename))/fisher-install.fish

# rbenv
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
