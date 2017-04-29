if test -z "$Z_DATA"
  set -U Z_DATA "$HOME/.z"
end

if test ! -f "$Z_DATA"
  touch "$Z_DATA"
end

function __z_on_variable_pwd --on-variable PWD
  __z_add
end
