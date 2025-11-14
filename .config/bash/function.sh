function vetero() {
  curl wttr.in/$argv
}

function goinit() {
  echo "Enter the package name:" && read package;
  mkdir -p $package && cd $package
  go mod init github.com/$dirname/$package
  git init && touch main.go README.md
}

function laravelinit() {
  echo "Enter the project name:" && read projName;
  curl -s "https://laravel.build/$projName" | bash
}

function gau() {
  echo "Enter the username:" && read username;
  if [[ -n "$username" ]]; then
    git remote add origin "$GH_URL/$username/$(basename $(pwd)).git"
    git remote -v
  else
    echo "Please provide the username you want to use."
  fi
}

function gd() {
  local dir
  dir=$(ghq list -p | fzf)
  if [[ -n "$dir" ]]; then
    cd "$dir"
  fi
}

function gco() {
  local branch
  branch=$(git branch --all | sed 's/^[* ]*//' | fzf)
  if [[ -n "$branch" ]]; then
    git checkout "$(echo $branch | sed 's#remotes/origin/##')"
  fi
}

function ggl() {
  echo "Searching for $argv on Google..."
  open "https://www.google.com/search?q=$argv"
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

function ccc() {
  tmux split-window -h && \
  tmux split-window -v && \
  tmux select-pane -t 0 && \
  tmux split-window -v && \
  tmux select-pane -t 2 && \
  tmux split-window -v && \
  tmux select-pane -t 4 && \
  tmux split-window -v
}

function cccw() {
  CURRENT_DIR=$(pwd)
  CURRENT_PANE=$WEZTERM_PANE
  RIGHT_TOP=$(wezterm cli split-pane --right --percent 50)
  wezterm cli activate-pane --pane-id $CURRENT_PANE
  RIGHT_BOTTOM=$(wezterm cli split-pane --bottom --percent 50)
  wezterm cli activate-pane --pane-id $RIGHT_TOP
  wezterm cli split-pane --bottom --percent 50
}

function aws2fa() {
  aws sts get-session-token
}
