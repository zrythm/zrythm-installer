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

set -ex

bottle_or_zip=$1

formula_dir=/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula
cache_dir="$(brew --cache)"

if [ "$bottle_or_zip" = "bottle" ]; then
  bottle_file=$2
  bottle_filename="$(basename $bottle_file)"
  formula_file=$3
  tarball=$4
  tarball_filename="$(git ls-remote https://git.zrythm.org/zrythm/zrythm | grep HEAD | awk '{print $1}').tar.gz"
  zrythm_version=$5
  carla_version=$6
  carla_bottle_ver=$7

  wget https://git.zrythm.org/zrythm/zrythm/archive/$tarball_filename

  # copy formula file to where it needs to be
  if [[ "$bottle_filename" == *"rial"* ]]; then
    cp $formula_file $formula_dir/zrythm-trial.rb
    formula_filename="zrythm-trial.rb"
    pkg_name="zrythm-trial"
    sed -i -e "s/trial_ver=false/trial_ver=true/" \
      $formula_dir/zrythm-trial.rb
    sed -i -e "1s/Zrythm/ZrythmTrial/" \
      $formula_dir/zrythm-trial.rb
  else
    formula_filename="zrythm.rb"
    pkg_name="zrythm"
    cp $formula_file $formula_dir/$formula_filename
  fi
  cp tools/osx/carla-git.rb $formula_dir/
  sed -i -e "s/@TARBALL_FILENAME@/$tarball_filename/" \
    $formula_dir/$formula_filename
  sed -i -e "s/@VERSION@/$zrythm_version/g" \
    $formula_dir/$formula_filename
  sed -i -e "s/@VERSION@/$carla_version/" \
    $formula_dir/carla-git.rb
  sed -i -e "s/@BOTTLE_VERSION@/$carla_bottle_ver/" \
    $formula_dir/carla-git.rb
  sed -i -e "s/@SHA256@/$(openssl sha256 -r $tarball_filename | awk '{print $1;}')/" \
    $formula_dir/$formula_filename

  # build bottle
  brew unlink carla-git || true
  brew install --verbose --debug --build-bottle carla-git
  brew bottle carla-git
  brew link --overwrite carla-git
  brew unlink carla-git
  brew unlink zrythm || true
  brew unlink zrythm-trial || true
  brew install --verbose --debug --build-bottle $pkg_name || true
  brew bottle $pkg_name
  brew link --overwrite $pkg_name
  destdir="$(dirname $bottle_file)"
  carla_git_bottle_filename="carla-git--$carla_bottle_ver.catalina.bottle.tar.gz"
  rm -rf $destdir/$carla_git_bottle_filename
  mv $carla_git_bottle_filename "$destdir"/
  rm -rf $bottle_file
  mv $pkg_name--$zrythm_version.catalina.bottle.tar.gz $bottle_file
elif [ "$bottle_or_zip" = "zip" ]; then
  bottle_file=$2
  bottle_filename="$(basename $bottle_file)"
  zip_file=$3
  zip_filename="$(basename $zip_file)"
  zrythm_version=$4
  carla_bottle_ver=$5
  carla_bottle_file=$6
  tmp="${zip_filename%.*}"
  mkdir -p $tmp
  rm -rf $zip_file
  cp installer-osx.sh.in $tmp/installer.sh
  sed -i -e "s/@VERSION@/$zrythm_version/" \
    $tmp/installer.sh
  sed -i -e "s/@CARLA_VERSION@/$carla_bottle_ver/" \
    $tmp/installer.sh
  if [[ "$bottle_filename" == *"rial"* ]]; then
    cp README-osx-trial.in $tmp/README
    sed -i -e "s/@TRIAL@/-trial/g" \
      $tmp/installer.sh
  else
    cp README-osx.in $tmp/README
    sed -i -e "s/@_AT_@/@/g" $tmp/README
    sed -i -e "s/@TRIAL@//g" $tmp/installer.sh
  fi
  sed -i -e "s/@VERSION@/$zrythm_version/" \
    $tmp/README
  mkdir -p $tmp/bin
  mkdir -p $tmp/formulae
  mkdir -p $tmp/icons
  mkdir -p $tmp/src
  #cp $bottle_file $tmp/bin/zrythm-$zrythm_version.catalina.bottle.tar.gz
  cp $carla_bottle_file $tmp/bin/carla-git.catalina.bottle.tar.gz
  cp $formula_dir/zrythm*.rb $tmp/formulae/
  cp -r /tmp/breeze-dark $tmp/icons/
  rm $tmp/*-e
  zip -r $zip_file $tmp
fi
