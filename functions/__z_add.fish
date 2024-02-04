function __z_add -d "Add PATH to .z file"
  set -l path (dirname (status -f))
  set -l tmpfile (mktemp $Z_DATA.XXXXXX)

  if test -f $tmpfile
    zadd --pwd="$PWD" --now=(date +%s) $Z_DATA ^ /dev/null > $tmpfile
    mv -f $tmpfile $Z_DATA
  end
end
