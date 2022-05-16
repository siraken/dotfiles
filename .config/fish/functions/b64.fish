# base 64
# available on macOS

function b64
  base64 $argv[1] | pbcopy
  echo Copied to Clipboard: $argv[1]
end
