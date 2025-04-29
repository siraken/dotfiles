##################################################
# Eval
##################################################
# TODO: enable copilot

if [ -e "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

if [ -f "$HOME/Developer/google-cloud-sdk/path.bash.inc" ]; then
  . "$HOME/Developer/google-cloud-sdk/path.bash.inc";
fi

if [ -f "$HOME/Developer/google-cloud-sdk/completion.bash.inc" ]; then
  . "$HOME/Developer/google-cloud-sdk/completion.bash.inc";
fi

# . "$HOME/.cargo/env"

# complete -f -c dotnet -a "(dotnet complete (commandline -cp))"

if type ng &>/dev/null; then
  source <(ng completion script)
fi

if type direnv &> /dev/null; then
  eval "$(direnv hook bash)"
fi

eval "$(zoxide init bash)"
eval "$(starship init bash)"

