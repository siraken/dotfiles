autoload -Uz compinit
compinit

export SSH_AUTH_SOCK="$HOME/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
export VOLTA_HOME="$HOME/.volta"
export GOPATH="$HOME/go"

export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="$HOME/Developer/flutter/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.progate/bin:$PATH"

if [ -e "$HOME/Library/Android/sdk" ]; then
  export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
fi

if [ -e "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

if [ -e "$HOME/.deno" ]; then
  export PATH="$HOME/.deno/bin:$PATH"
fi

if [ -e "$HOME/Library/Application Support/JetBrains/Toolbox" ]; then
  export PATH="$HOME/Library/Application Support/JetBrains/Toolbox/scripts:$PATH"
fi

if [ -f "$HOME/Developer/google-cloud-sdk/path.zsh.inc" ]; then
  . "$HOME/Developer/google-cloud-sdk/path.zsh.inc";
fi
if [ -f "$HOME/Developer/google-cloud-sdk/completion.zsh.inc" ]; then
  . "$HOME/Developer/google-cloud-sdk/completion.zsh.inc";
fi

if type ng &>/dev/null; then
  source <(ng completion script)
fi
