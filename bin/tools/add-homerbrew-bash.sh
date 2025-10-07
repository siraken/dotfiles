#!/bin/bash

brew_bash_path=$(brew --prefix)/bin/bash

if ! grep -q "$brew_bash_path" /etc/shells; then
  echo "$brew_bash_path" | sudo tee -a /etc/shells
  if [ $? -eq 0 ]; then
    echo "Homebrew の Bash を /etc/shells に追加しました: $brew_bash_path"
  else
    echo "エラー: /etc/shells への書き込みに失敗しました。sudo 権限を確認してください。"
    exit 1
  fi
else
  echo "Homebrew の Bash はすでに /etc/shells に登録されています: $brew_bash_path"
fi

exit 0
