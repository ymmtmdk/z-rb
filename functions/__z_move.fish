function __z_move -d "Jump to a recent directory."
  set -g z_path (dirname (status -f))
  set -l target

  if not test -e $Z_DATA
    touch $Z_DATA
  end

  set target (/usr/bin/ruby $z_path/z.rb "$argv" (date +%s) "$Z_DATA")
  echo ruby "$argv" (date +%s) "$Z_DATA"

  if test "$status" -gt 0
    return
  end

  if test -z "$target"
    printf "'%s' did not match any results" "$argv"
    return 1
  end

  pushd "$target"
end

