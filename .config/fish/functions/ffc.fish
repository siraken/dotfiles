# ffc - File from Clipboard

function ffc
  pbpaste > $argv[1]
  echo Updated File: $argv[1]
end
