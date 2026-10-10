function gd() {
  local dir
  dir=$(gd-select) && [ -n "$dir" ] && cd "$dir"
}
