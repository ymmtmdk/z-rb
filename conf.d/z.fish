if test -z "$Z_DATA"
  set -U Z_DATA "$HOME/.z"
end

if test ! -f "$Z_DATA"
  touch "$Z_DATA"
end

function __z_on_variable_pwd --on-variable PWD
  __z_add
end

function __fish_command_not_found_handler --on-event fish_command_not_found
  autocdz $argv
end

