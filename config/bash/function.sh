function gau() {
  echo "Enter the username:" && read username
  if [[ -n $username ]]; then
    git remote add origin "https://github.com/$username/$(basename $(pwd)).git"
    git remote -v
  else
    echo "Please provide the username you want to use."
  fi
}

function gd() {
  local dir
  dir=$(gd-select) && [ -n "$dir" ] && cd "$dir"
}
