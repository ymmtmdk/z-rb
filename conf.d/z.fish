if test -z "$Z_DATA"
  set -U Z_DATA "$HOME/.z"
end

if test ! -f "$Z_DATA"
  touch "$Z_DATA"
end

function __z_on_variable_pwd --on-variable PWD
  __z_add
end

# autocdz
function autocdz
  if test (count $argv) -gt 1
    echo "fish: Unknown command '$argv[1]'" >&2
  else if test -d $argv
    cd $argv
  else if __z_move $argv
    echo cd $PWD
  end
end

function __fish_command_not_found_handler --on-event fish_command_not_found
  autocdz $argv
end

