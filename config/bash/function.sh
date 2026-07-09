function vetero() {
  curl wttr.in/$argv
}

function goinit() {
  echo "Enter the package name:" && read package
  mkdir -p $package && cd $package
  go mod init github.com/$dirname/$package
  git init && touch main.go README.md
}

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

function meme() {
  echo "Searching for $argv on Know Your Meme..."
  open "https://knowyourmeme.com/search?q=$argv"
}

function cani() {
  echo "Can I use \"$argv\"...?"
  open "https://caniuse.com?search=$argv"
}

function caniemail() {
  echo "Can I email \"$argv\"...?"
  open "https://caniemail.com/search/?s=$argv"
}

function ide() {
  tmux split-window -v -p 30
  tmux split-window -h -p 50
}
