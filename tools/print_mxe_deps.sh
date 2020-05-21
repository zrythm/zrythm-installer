#! /bin/bash
#
#  Copyright (C) 2019-2020 Alexandros Theodotou <alex at zrythm dot org>
#
#  This file is part of Zrythm
#
#  Zrythm is free software: you can redistribute it and/or modify
#  it under the terms of the GNU Affero General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  Zrythm is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU Affero General Public License for more details.
#
#  You should have received a copy of the GNU Affero General Public License
#  along with Zrythm.  If not, see <https://www.gnu.org/licenses/>.
#

set -e

mxe_root=$1
dest_file=$2

rm -rf $dest_file

tmp_file=/tmp/zrythm-deps.txt

deps=$(make -C $mxe_root -s show-upstream-deps-zrythm)
for dep in $deps; do
  echo "$dep $(make -C $mxe_root -s print-ver-$dep)" >> $tmp_file
done

mv $tmp_file $dest_file
