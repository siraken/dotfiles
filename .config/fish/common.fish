##################################################
# > Common Functions
##################################################
function info_message
  set_color white -b blue
  printf " INFO "
  set_color normal
  printf " %s" $argv[1]
end

function success_message
  set_color white -b green
  printf " SUCCESS "
  set_color normal
  printf " %s" $argv[1]
end

function error_message
  set_color white -b red
  printf " ERROR "
  set_color normal
  printf " %s" $argv[1]
end

function warning_message
  set_color white -b yellow
  printf " WARNING "
  set_color normal
  printf " %s" $argv[1]
end

function debug_message
  set_color white -b magenta
  printf " DEBUG "
  set_color normal
  printf " %s" $argv[1]
end
