# pnpm
if test -f $FISH_CONFIG_PATH/pnpm.fish
  source $FISH_CONFIG_PATH/pnpm.fish
else
  # command -q pnpm; and status --is-interactive;
  # and pnpm install-completion | source
end

# dotnet
complete -f -c dotnet -a "(dotnet complete (commandline -cp))"

