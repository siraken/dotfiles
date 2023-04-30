##################################################
# > Functions
##################################################
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
    git remote add origin "$GH_URL/$username/$(basename $(pwd)).git"
    git remote -v
  else
    echo "Please provide the username you want to use."
  end
end

# Open splitted tmux
function ide
  tmux split-window -v -p 30
  tmux split-window -h -p 50
end