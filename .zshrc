export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"
export PATH="~/.composer/vendor/bin:$PATH"
export PATH="$PATH:/Users/siraken/Developer/flutter/bin"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh" # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/siraken/Developer/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/siraken/Developer/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/siraken/Developer/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/siraken/Developer/google-cloud-sdk/completion.zsh.inc'; fi
eval "$(anyenv init -)"

# pure
autoload -U promptinit; promptinit
# prompt pure

# start fish shell on login
fish

# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"
