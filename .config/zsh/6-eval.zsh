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

