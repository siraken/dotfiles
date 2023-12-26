##################################################
# Functions
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
# FIXME: from fish shell
function goinit() {
  echo "Enter the package name:" && read package;
  mkdir -p $package && cd $package
  go mod init github.com/$dirname/$package
  git init && touch main.go README.md
}

# Initialize Laravel app
# FIXME: from fish shell
function laravelinit() {
  echo "Enter the project name:" && read projName;
  curl -s "https://laravel.build/$projName" | bash
}

# Git Add Url
# FIXME: from fish shell
function gau() {
  # echo "Enter the username:" && read username;
  # if test -n "$username"
  #   git remote add origin "$GH_URL/$username/"(basename (pwd))".git"
  #   git remote -v
  # else
  #   echo "Please provide the username you want to use."
  # end
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
  echo "Can I email \"$argv\"...?"
  open "https://caniemail.com/search/?s=$argv"
}

# Open Tmux with IDE-style
function ide() {
  tmux split-window -v -p 30
  tmux split-window -h -p 50
}

# Restart yabai and skhd
function res-yabai() {
  yabai --restart-service
  skhd --restart-service
}

# function トウキョウ・シャンディ・
#   if test -f ./vendor/bin/sail
#     if test -f pnpm-lock.yaml
#       sail pnpm $argv
#     end
#     if test -f yarn.lock
#       sail yarn $argv
#     end
#     if test -f package-lock.json
#       sail npm $argv
#     end
#   else
#     if test -f pnpm-lock.yaml
#       pnpm $argv
#     end
#     if test -f yarn.lock
#       yarn $argv
#     end
#     if test -f package-lock.json
#       npm $argv
#     end
#   end
# end

