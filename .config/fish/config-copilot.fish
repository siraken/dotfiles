# GitHub Copilot CLI Helper
# See: https://zenn.dev/tunefs/articles/b284d532ed5460
function github-copilot_helper
  set -l TMPFILE (mktemp)
  trap 'rm -f $TMPFILE' EXIT
  if github-copilot-cli $argv[1] "$argv[2..]" --shellout $TMPFILE
    if [ -e "$TMPFILE" ]
      set -l FIXED_CMD (cat $TMPFILE)
      eval "$FIXED_CMD"
    else
      echo "Apologies! Extracting command failed"
    end
  else
    return 1
  end
end

set -U fish_features qmark-noglob

if type -q github-copilot_helper
  alias ??='github-copilot_helper what-the-shell'
  alias git?='github-copilot_helper git-assist'
  alias gh?='github-copilot_helper gh-assist'
end
