##################################################
# ==> Aliases
##################################################
alias g="git"
alias gs="git status"
alias lzg="lazygit"
alias lzd="lazydocker"
alias cat='bat'
alias fzf="fzf --preview 'bat --color=always --style=numbers {}'"
alias posh="pwsh"
alias cls="clear"
alias n="node"
alias md="mkdir"
alias e="emacs"
alias bim="vim"
alias nbim="nvim"
alias nf="neofetch"

##################################################
# ==> Path
##################################################
status --is-interactive; and rbenv init - fish | source
status --is-interactive; and pyenv init - | source

##################################################
# ==> OS-specific config
##################################################
switch (uname)
  case Darwin
    source (dirname (status --current-filename))/config-darwin.fish
  case Linux
    source (dirname (status --current-filename))/config-linux.fish
end

# Starship
# starship init fish | source

set fish_greeting

set -x GH_URL https://github.com

##################################################
# ==> Variables
##################################################
# nvm
set --universal nvm_default_version v16.19.0
# set --universal nvm_default_version v18.12.1
set --universal nvm_default_packages yarn

##################################################
# ==> Functions
##################################################
# Docker upload
function docker-upload
  echo $1
  # docker build -t $1 .
  # docker save -o $1.tar $1
end

# Weather
function weather
  curl wttr.in/$argv
end

# Initialize Go app
function go-init
  echo "Enter the package name:" && read package;
  mkdir -p $package && cd $package
  go mod init github.com/$dirname/$package
  git init && touch main.go README.md
end

# Add git remote URL with current directory name
function git-add-url
  echo "Enter the username:" && read username;
  if test -n "$username"
    git remote add origin "$GH_URL/$username/$(basename $(pwd)).git"
    git remote -v
  else
    echo "Please provide the username you want to use."
  end
end

# source (dirname (status --current-filename))/f.fish
# source (dirname (status --current-filename))/fisher-install.fish

