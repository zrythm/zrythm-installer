#! /bin/bash
#
# Copyright (C) 2020-2021 Alexandros Theodotou <alex at zrythm dot org>
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

commit=$1
inner_dir=Carla-$commit

pushd /tmp
wget https://github.com/falkTX/Carla/archive/$commit.zip
unzip $commit.zip
rm $inner_dir/bin/carla.lv2/resources
mv $inner_dir $inner_dir.old
cp -rL $inner_dir.old $inner_dir
tar cfz $inner_dir.tar.gz $inner_dir
rsync -av $inner_dir.tar.gz $RSYNC_USER@$RSYNC_PATH
popd
