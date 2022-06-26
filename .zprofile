if [ -e "/opt/homebrew/bin/brew" ]
then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -e "/home/linuxbrew/.linuxbrew/bin/brew" ]
then
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/siraken/.zprofile
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
  
if [ -e "$HOME/.rbenv" ]
then
    eval "$(rbenv init -)"
fi
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
