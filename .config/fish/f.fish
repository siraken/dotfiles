##################################################
# ==> Functions
##################################################
function info_message
  set_color white -b blue
  echo $argv[1]
  set_color normal
end

function success_message
  set_color white -b green
  echo $argv[1]
  set_color normal
end

function error_message
  set_color white -b red
  echo $argv[1]
  set_color normal
end

function warning_message
  set_color white -b yellow
  echo $argv[1]
  set_color normal
end

function debug_message
  set_color white -b magenta
  echo $argv[1]
  set_color normal
end

# Docker upload
function docker-upload
  echo $1
  # docker build -t $1 .
  # docker save -o $1.tar $1
end

# Weather
function weather
  curl wttr.in/$argv
end

# Initialize Go app
function go-init
  echo "Enter the package name:" && read package;
  mkdir -p $package && cd $package
  go mod init github.com/$dirname/$package
  git init && touch main.go README.md
end

# gau - Git Add URL
# add git remote URL with current directory name
function gau
  echo "Enter the username:" && read username;
  if test -n "$username"
    git remote add origin "$GH_URL/$username/$(basename $(pwd)).git"
    git remote -v
  else
    echo "Please provide the username you want to use."
  end
end

# Open splitted tmux
function ide
  tmux
  tmux split-window -v -p 30
  tmux split-window -h -p 66
  tmux split-window -h -p 50
end

