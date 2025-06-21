##################################################
# Function
##################################################
# Docker upload
function docker-upload() {
  echo $1
  # docker build -t $1 .
  # docker tag $1 $2
  # docker push $2
}

# Docker init
function docker-init() {
  printf "version: \"3\"\nservices:\n" > docker-compose.yml
  printf "FROM IMAGE\n\n" > Dockerfile
}

# Weather
function weather() {
  curl wttr.in/$argv
}

# Initialize Go app
function goinit() {
  echo "Enter the package name:" && read package;
  mkdir -p $package && cd $package
  go mod init github.com/$dirname/$package
  git init && touch main.go README.md
}

# Initialize Laravel app
function laravelinit() {
  echo "Enter the project name:" && read projName;
  curl -s "https://laravel.build/$projName" | bash
}

# Git Add Url
function gau() {
  echo "Enter the username:" && read username;
  if [[ -n "$username" ]]; then
    git remote add origin "$GH_URL/$username/$(basename $(pwd)).git"
    git remote -v
  else
    echo "Please provide the username you want to use."
  fi
}

# Google Search
function ggl() {
  echo "Searching for $argv on Google..."
  open "https://www.google.com/search?q=$argv"
}

# Find memes on Know Your Meme
function meme() {
  echo "Searching for $argv on Know Your Meme..."
  open "https://knowyourmeme.com/search?q=$argv"
}

# Can I use
function cani() {
  echo "Can I use \"$argv\"...?"
  open "https://caniuse.com?search=$argv"
}

# Can I email
function caniemail() {
  echo "Can I email \"$argv\"...?"
  open "https://caniemail.com/search/?s=$argv"
}

# Open Tmux with IDE-style
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
  # CURRENT_DIR=$(pwd)
  # CURRENT_PANE=$(wezterm cli list --format json | jq '.[] | select(.is_active == true) | .pane_id')
  # RIGHT_TOP=$(wezterm cli split-pane --right --percent 50)
  # wezterm cli activate-pane --pane-id $CURRENT_PANE
  # RIGHT_BOTTOM=$(wezterm cli split-pane --bottom --percent 50)
  # wezterm cli activate-pane --pane-id $RIGHT_TOP
  # wezterm cli split-pane --bottom --percent 50
}

# Restart yabai and skhd
function res-yabai() {
  yabai --restart-service
  skhd --restart-service
}
