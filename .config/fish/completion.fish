# gcloud
if test -f $HOME/Developer/google-cloud-sdk/completion.fish.inc
    source "$HOME/Developer/google-cloud-sdk/completion.fish.inc"
end

# dotnet
complete -f -c dotnet -a "(dotnet complete (commandline -cp))"
