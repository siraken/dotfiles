if [ -f "$HOME/Developer/google-cloud-sdk/path.bash.inc" ]; then
  . "$HOME/Developer/google-cloud-sdk/path.bash.inc";
fi

if [ -f "$HOME/Developer/google-cloud-sdk/completion.bash.inc" ]; then
  . "$HOME/Developer/google-cloud-sdk/completion.bash.inc";
fi

if [ -f "$HOME/dotfiles/.config/bash/completions/git-completion.bash" ]; then
  . "$HOME/dotfiles/.config/bash/completions/git-completion.bash";
fi

# if [ -f "$HOME/.cargo/env" ]; then
#   . "$HOME/.cargo/env"
# fi

# complete -f -c dotnet -a "(dotnet complete (commandline -cp))"

if type ng &>/dev/null; then
  source <(ng completion script)
fi

if type mise &> /dev/null; then
  eval "$(mise activate bash)"
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
