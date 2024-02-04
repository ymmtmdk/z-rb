function __z -d "Jump to a recent directory."
  set -l option 'move'
  set -l arg
  set -l typ 'frecent'
  set -g z_path (dirname (status -f))
  set -l target

  if not test -e $Z_DATA
    touch $Z_DATA
  end

  set arg "$argv"

  if test 1 -eq (printf "%s" $arg | grep -c "^\/")
    set target $arg
  else
    # set target (awk -v t=(date +%s) -v option="$option" -v typ="$typ" -v q="$arg" -F "|" -f $z_path/z.awk "$Z_DATA")
    set target (/usr/bin/ruby $z_path/z.rb "$arg" (date +%s) "$Z_DATA")
    echo ruby --option="$option" --type="$typ" --query="$arg" --now=(date +%s) "$Z_DATA"
    # set target (zmove --option="$option" --type="$typ" --query="$arg" --now=(date +%s) "$Z_DATA")
  end

  if test "$status" -gt 0
    return
  end

  if test -z "$target"
    printf "'%s' did not match any results" "$arg"
    return 1
  end

  if contains -- ech $option
    printf "%s\n" "$target"
  else if not contains -- list $option
    pushd "$target"
  end
end
