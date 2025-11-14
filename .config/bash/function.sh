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

function awsmfa() {
  if [[ -z "$1" ]]; then
    echo "エラー: OTPトークンコードを引数として渡してください。" >&2
    return 1
  fi

  local OTP=$1
  local MFA_DEVICE_ARN
  local TOKEN
  local AWS_ACCESS_KEY_ID
  local AWS_SECRET_ACCESS_KEY
  local AWS_SESSION_TOKEN

  MFA_DEVICE_ARN=$(aws iam list-mfa-devices | jq '.MFADevices[0].SerialNumber' --raw-output)
  TOKEN=$(aws sts get-session-token --serial-number $MFA_DEVICE_ARN --token-code $OTP 2> /dev/null)

  if [[ -z "$TOKEN" ]]; then
    echo "エラー: トークンの取得に失敗しました。OTPが間違っているか、期限切れの可能性があります。" >&2
    return 1
  fi

  AWS_ACCESS_KEY_ID=$(echo $TOKEN | jq '.Credentials.AccessKeyId' --raw-output)
  AWS_SECRET_ACCESS_KEY=$(echo $TOKEN | jq '.Credentials.SecretAccessKey' --raw-output)
  AWS_SESSION_TOKEN=$(echo $TOKEN | jq '.Credentials.SessionToken' --raw-output)

  export AWS_ACCESS_KEY_ID
  export AWS_SECRET_ACCESS_KEY
  export AWS_SESSION_TOKEN

  echo "一時的な認証情報を設定しました。"
  echo "Expires at: $(echo $TOKEN | jq '.Credentials.Expiration' --raw-output)"
}
