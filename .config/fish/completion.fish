# pnpm
if test -f $FISH_CONFIG_PATH/pnpm.fish
    source $FISH_CONFIG_PATH/pnpm.fish
end

# gcloud
if test -f $HOME/Developer/google-cloud-sdk/completion.fish.inc
    source "$HOME/Developer/google-cloud-sdk/completion.fish.inc"
end

# dotnet
complete -f -c dotnet -a "(dotnet complete (commandline -cp))"
