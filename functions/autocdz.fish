function __z_add -d "Add PATH to .z file"
  set -l path (dirname (status -f))
  set -l tmpfile (mktemp $Z_DATA.XXXXXX)

  if test -f $tmpfile
    zadd --pwd="$argv" --now=(date +%s) $Z_DATA ^ /dev/null > $tmpfile
    mv -f $tmpfile $Z_DATA
  end
end

function __z_move -d "Jump to a recent directory."
  set -g path (dirname (status -f))
  set -l target

  echo TODO
  echo ruby "$argv" (date +%s) "$Z_DATA"
  set target (/usr/bin/ruby $path/zmove.rb "$argv" (date +%s) "$Z_DATA")

  if test "$status" -gt 0
    return $status
  end

  if test -z "$target"
    printf "'%s' did not match any results" "$argv"
    return 1
  end

  pushd "$target"
  return 0
end

function autocdz
  if test (count $argv) -gt 1
    echo "fish: Unknown command '$argv[1]'" >&2
  else if test -d $argv
    cd $argv
  else if __z_move $argv
    echo cd $PWD
  end
end

