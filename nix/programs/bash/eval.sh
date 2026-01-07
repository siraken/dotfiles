# Google Cloud SDK
if [ -f "$HOME/Developer/google-cloud-sdk/path.bash.inc" ]; then
  . "$HOME/Developer/google-cloud-sdk/path.bash.inc";
fi

if [ -f "$HOME/Developer/google-cloud-sdk/completion.bash.inc" ]; then
  . "$HOME/Developer/google-cloud-sdk/completion.bash.inc";
fi

# Angular CLI
if type ng &>/dev/null; then
  source <(ng completion script)
fi
