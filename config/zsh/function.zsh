# The zsh counterpart of config/bash/function.sh.

function gd() {
  local dir
  dir=$(gd-select) && [ -n "$dir" ] && cd "$dir"
}
