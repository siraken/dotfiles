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

if [ -e "$HOME/.rbenv" ]; then
  eval "$(rbenv init -)"
fi

if [ -f "$HOME/Developer/google-cloud-sdk/path.bash.inc" ]; then
  . "$HOME/Developer/google-cloud-sdk/path.bash.inc";
fi

if [ -f "$HOME/Developer/google-cloud-sdk/completion.bash.inc" ]; then
  . "$HOME/Developer/google-cloud-sdk/completion.bash.inc";
fi

if [ -s "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ]; then
  . "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
fi

# if [ -f "$HOME/.cargo/env" ]; then
#   . "$HOME/.cargo/env"
# fi

# complete -f -c dotnet -a "(dotnet complete (commandline -cp))"

if type ng &>/dev/null; then
  source <(ng completion script)
fi

if type direnv &> /dev/null; then
  eval "$(direnv hook bash)"
fi

if type starship &> /dev/null; then
  eval "$(starship init bash)"
fi

if type zoxide &> /dev/null; then
  eval "$(zoxide init bash)"
fi
