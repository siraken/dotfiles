##################################################
# ==> Powerlevel10k
# - Enable Powerlevel10k instant prompt.
# - Should stay close to the top of ~/.zshrc.
##################################################
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

##################################################
# ==> Paths
##################################################
export PATH="~/.composer/vendor/bin:$PATH"
export PATH="$PATH:/Users/siraken/Developer/flutter/bin"

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

if [ -e "$HOME/Library/Android/sdk" ]; then
  export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
fi

if [ -e "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

if [ -e "$HOME/.anyenv" ]; then
  # eval "$(anyenv init -)"
  export ANYENV_ROOT="$HOME/.anyenv"
  export PATH="$ANYENV_ROOT/bin:$PATH"
  if command -v anyenv 1>/dev/null 2>&1; then
    eval "$(anyenv init -)"
  fi
fi

if [ -e "$HOME/.deno" ]; then
  export PATH="/Users/siraken/.deno/bin:$PATH"
fi

if [ -e "$HOME/.progate" ]; then
  export PATH="$HOME/.progate/bin:$PATH"
fi

if [ -e "$HOME/Library/Application Support/JetBrains/Toolbox" ]; then
  export PATH="$HOME/Library/Application Support/JetBrains/Toolbox/scripts:$PATH"
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/siraken/Developer/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/siraken/Developer/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/siraken/Developer/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/siraken/Developer/google-cloud-sdk/completion.zsh.inc'; fi

# -------------------------------------------------------------------------------- start oh-my-zsh

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Zsh Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# oh my zsh
if [ -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
  plugins=(
    git
    macos
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-z
    zsh-nvm
  )
  source $ZSH/oh-my-zsh.sh
fi

# ----------------------------------------------------------------------------- end oh-my-zsh

##################################################
# ==> Functions
##################################################

# Initialize Go app
goinit () {
  dirname=${PWD##*/}
  echo "Enter the package name:" && read package;
  mkdir -p ${package} && cd ${package}
  go mod init github.com/${dirname}/${package}
  git init && touch main.go README.md
}

# Weather
weather() {
  curl "wttr.in/$1"
}

# Make Docker image tarball
docker-upload () {
  docker build -t ${1} .
  docker save -o ${1}.tar ${1}
}

# tmux IDE
tmux-ide() {
  case $1 in
    "l1r3")
      tmux split-window -h
      tmux resize-pane -R 25
      tmux split-window -v
      tmux split-window -v
    ;;
    *)
      echo "$#"
    ;;
  esac
}

# For Hyper
precmd() {
  pwd=$(pwd)
  cwd=${pwd##*/}
  print -Pn "\e]0;$cwd\a"
}
preexec() {
  printf "\033]0;%s\a" "${1%% *} | $cwd"
}

##################################################
# ==> Aliases
##################################################
alias vi='nvim'
alias vim='nvim'
alias bim='nvim'
alias gs='git status'
alias cat='bat'
alias fzf="fzf --preview 'bat --color=always --style=numbers {}'"
alias posh="pwsh"
alias cls="clear"

case ${OSTYPE} in
  darwin*)
    alias ls='ll'
    alias ll='exa -l -g --icons'
    alias lla='ll -a'
    alias llt='ll --tree'
    alias llta='llt -a'
    alias mamp-htdocs="cd /Applications/MAMP/htdocs"
    ;;
  linux*)
    ;;
esac

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# startship
# eval "$(starship init zsh)"
