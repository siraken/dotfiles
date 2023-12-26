setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt share_history
setopt list_packed
setopt correct
setopt auto_cd

autoload -Uz colors && colors
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ''

export CLICOLOR=true

##################################################
# > Variable
##################################################
export EDITOR='nvim'
export GH_URL='https://github.com'

##################################################
# Path
##################################################
export SSH_AUTH_SOCK="$HOME/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
export VOLTA_HOME="$HOME/.volta"
export GOPATH="$HOME/go"
export PNPM_HOME="$HOME/.pnpm"
export MODULAR_HOME="$HOME/.modular"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH" # Use openssl installed by homebrew
export PATH="$GOPATH/bin:$PATH"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="$PNPM_HOME:$PATH"
export PATH="$HOME/.rye/shims:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.deno/bin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="$HOME/Developer/flutter/bin:$PATH"
export PATH="$HOME/.pub-cache/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.progate/bin:$PATH"
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
export PATH="$HOME/Library/Application Support/JetBrains/Toolbox/scripts:$PATH"

##################################################
# > Functions
##################################################
# Docker upload
function docker-upload() {
  echo $1
  # docker build -t $1 .
  # docker tag $1 $2
  # docker push $2
}

# Docker init
function docker-init() {
  printf "version: \"3\"\nservices:\n" > docker-compose.yml
  printf "FROM IMAGE\n\n" > Dockerfile
}

# Weather
function weather() {
  curl wttr.in/$argv
}

# Initialize Go app
# FIXME: from fish shell
function goinit() {
  echo "Enter the package name:" && read package;
  mkdir -p $package && cd $package
  go mod init github.com/$dirname/$package
  git init && touch main.go README.md
}

# Initialize Laravel app
# FIXME: from fish shell
function laravelinit() {
  echo "Enter the project name:" && read projName;
  curl -s "https://laravel.build/$projName" | bash
}

# Git Add Url
# FIXME: from fish shell
function gaurl() {
  echo "Enter the username:" && read username;
  if test -n "$username"
    git remote add origin "$GH_URL/$username/"(basename (pwd))".git"
    git remote -v
  else
    echo "Please provide the username you want to use."
  end
}

# Google Search
function ggl() {
  echo "Searching for $argv on Google..."
  open "https://www.google.com/search?q=$argv"
}

# Find memes on Know Your Meme
function meme() {
  echo "Searching for $argv on Know Your Meme..."
  open "https://knowyourmeme.com/search?q=$argv"
}

# Can I use
function cani() {
  echo "Can I email \"$argv\"...?"
  open "https://caniemail.com/search/?s=$argv"
}

# Open Tmux with IDE-style
function ide() {
  tmux split-window -v -p 30
  tmux split-window -h -p 50
}

# Restart yabai and skhd
function res-yabai() {
  yabai --restart-service
  skhd --restart-service
}

if [ -e "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# function トウキョウ・シャンディ・
#   if test -f ./vendor/bin/sail
#     if test -f pnpm-lock.yaml
#       sail pnpm $argv
#     end
#     if test -f yarn.lock
#       sail yarn $argv
#     end
#     if test -f package-lock.json
#       sail npm $argv
#     end
#   else
#     if test -f pnpm-lock.yaml
#       pnpm $argv
#     end
#     if test -f yarn.lock
#       yarn $argv
#     end
#     if test -f package-lock.json
#       npm $argv
#     end
#   end
# end

##################################################
# Alias
##################################################
# alias ls="ls -p -G"
# alias la "ls -A"
# alias ll="ls -l"
# alias lla="ls -A"
alias g='git'
alias gs='git status'
alias lzg="lazygit"
alias lzd="lazydocker"
alias fzf="fzf --preview 'bat --color=always --style=numbers {}'"
alias posh="pwsh"
alias cls='clear'
alias md="mkdir"
alias e="emacs"
alias lvim="/usr/bin/vim"
alias vim='nvim'
alias datetime="date '+%Y-%m-%d %H:%H:%S'"
alias sail="[ -f sail ] && sh sail || sh vendor/bin/sail"
alias dep="[ -f dep ] && sh dep || sh vendor/bin/dep"
alias mrm="touch README.md"
alias rb="ruby"
alias py="python"
alias n="node"
alias gopj="cd $GOPATH/src/github.com/"
alias rustrepl="evcxr"
alias -g G='| grep'
alias -g L='| less'
alias -g F='| fzf'
alias -g C='| pbcopy'
# Aliases for macOS
alias ii="open"
alias mamp-htdocs="cd /Applications/MAMP/htdocs"
alias lisp-server='sbcl --load \
  $HOME/.local/share/nvim/site/pack/packer/start/vlime/lisp/start-vlime.lisp'

# if type -q bat
#   alias cat="bat"
# end
#
# if type -q eza
#   alias ll="eza -l -g --icons"
#   alias lla="ll -a"
# end

# TODO: enable copilot

if [ -f "$HOME/Developer/google-cloud-sdk/path.zsh.inc" ]; then
  . "$HOME/Developer/google-cloud-sdk/path.zsh.inc";
fi
if [ -f "$HOME/Developer/google-cloud-sdk/completion.zsh.inc" ]; then
  . "$HOME/Developer/google-cloud-sdk/completion.zsh.inc";
fi
# if [ -f "$HOME/pnpm.zsh" ]; then
#   . "$HOME/pnpm.zsh";
# fi
# complete -f -c dotnet -a "(dotnet complete (commandline -cp))"

if type ng &>/dev/null; then
  source <(ng completion script)
fi

if type direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

