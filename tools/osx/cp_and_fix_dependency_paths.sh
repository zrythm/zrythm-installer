#!/bin/bash

exe="$1"
prefix_before="$2"
prefix_after="$3"

# fix binary/library paths
echo "processing executable $exe..."
changes=""
for lib in `otool -L "$exe" | egrep "($prefix_before)" | awk '{print $1}'` ; do
  base=`basename $lib`
  echo "copying $base from $(dirname $lib) to $prefix_after"
  mkdir -p "$prefix_after"
  cp "$lib" "$prefix_after"/
  changes="$changes -change $lib $prefix_after/$base"
done
if test "x$changes" != "x" ; then
  install_name_tool $changes $exe
fi

echo "done"
