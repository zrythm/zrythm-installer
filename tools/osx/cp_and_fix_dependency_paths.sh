#!/bin/bash

exe="$1"
prefix_before="$2"
prefix_after="$3"
mode="$4"
recurse="$5"

#set -x

if [[ "$mode" == "fix-in-dir" ]]; then
  dir_name="$prefix_after"
  for file in `ls "$dir_name"`; do
    bash $0 "$dir_name/$file" $2 $3 "fix" "false"
  done
else
  echo "processing executable $exe..."
  changes=""
  libs=`otool -L "$exe" | sed '1d' | egrep "($prefix_before|$prefix_after)" | awk '{print $1}'`
  if [[ "$mode" == "copy" ]] && [[ "$exe" == *".dylib" ]]; then
    libs="$(echo "$libs" | grep -v $(basename $exe))"
  fi
  echo "libs: $libs"

  for lib in $libs; do
    base=`basename $lib`
    mkdir -p "$prefix_after"
    if [[ "$mode" == "copy" ]]; then
      echo "copying $base from $(dirname $lib) to $prefix_after"
      cp "$lib" "$prefix_after"/
      chmod +rw "$prefix_after"/"$base"
    fi
    changes="$changes -change $lib $prefix_after/$base"
    if [[ "$recurse" == "true" ]]; then
      bash $0 "$prefix_after/$base" $2 $3 $4 $5
    fi
  done
  if [[ "$mode" == "fix" ]] && test "x$changes" != "x" ; then
    echo "install_name_tool $changes $exe"
    install_name_tool $changes $exe
  fi
fi

echo "done"
