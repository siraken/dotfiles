##################################################
# > Functions
##################################################
# Docker upload
function docker-upload
  echo $1
  # docker build -t $1 .
  # docker save -o $1.tar $1
end

# Docker init
function docker-init
  printf "version: \"3\"\nservices:\n" > docker-compose.yml
  printf "FROM IMAGE\n\n" > Dockerfile
end

# Weather
function weather
  curl wttr.in/$argv
end

# Initialize Go app
function goinit
  echo "Enter the package name:" && read package;
  mkdir -p $package && cd $package
  go mod init github.com/$dirname/$package
  git init && touch main.go README.md
end

# gau - Git Add URL
# Add git remote URL with current directory name
function gau
  echo "Enter the username:" && read username;
  if test -n "$username"
    git remote add origin "$GH_URL/$username/"(basename (pwd))".git"
    git remote -v
  else
    echo "Please provide the username you want to use."
  end
end

# ggl
# Google Search
function ggl
  echo "Searching for $argv on Google..."
  open "https://www.google.com/search?q=$argv"
end

# meme
# Find memes on Know Your Meme
function meme
  echo "Searching for $argv on Know Your Meme..."
  open "https://knowyourmeme.com/search?q=$argv"
end

# cani
# Can I use
function cani
  echo "Can I use \"$argv\"...?"
  open "https://caniuse.com/?search=$argv"
end

# caniemail
# Can I email
function caniemail
  echo "Can I email \"$argv\"...?"
  open "https://caniemail.com/search/?s=$argv"
end

# Open splitted tmux
function ide
  tmux split-window -v -p 30
  tmux split-window -h -p 50
end

# Restart yabai and skhd
function res-yabai
  yabai --restart-service
  skhd --restart-service
end

