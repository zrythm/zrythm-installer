#!/bin/bash
#
# Copyright (C) 2021 Alexandros Theodotou <alex at zrythm dot org>
#
# This file is part of Zrythm
#
# Zrythm is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Zrythm is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with Zrythm.  If not, see <https://www.gnu.org/licenses/>.

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
