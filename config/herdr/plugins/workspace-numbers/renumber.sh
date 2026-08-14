#!/usr/bin/env bash
# 全 workspace の番号を $num トークンとして push し直す。
# keys.switch_workspace は 1..9 しか受け付けないので、10 番以降は「押せない番号」を
# 出さないようトークンを消す。
set -euo pipefail

# プラグインのコマンドは PATH に herdr が居ることを前提にできないので、
# herdr が渡してくる絶対パスを優先する。
herdr=${HERDR_BIN_PATH:-herdr}

# 同じ --source から push したトークンだけが上書き・削除の対象になる。
source_id=siraken.workspace-numbers

"${herdr}" workspace list |
  jq -r '.result.workspaces[] | "\(.workspace_id)\t\(.number)"' |
  while IFS=$'\t' read -r workspace_id number; do
    if ((number <= 9)); then
      "${herdr}" workspace report-metadata "${workspace_id}" \
        --source "${source_id}" --token "num=${number}" >/dev/null
    else
      "${herdr}" workspace report-metadata "${workspace_id}" \
        --source "${source_id}" --clear-token num >/dev/null
    fi
  done
