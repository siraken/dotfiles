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
