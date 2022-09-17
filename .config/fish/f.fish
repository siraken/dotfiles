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
