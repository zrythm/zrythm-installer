#! /bin/bash

set -ex

bottle_or_zip=$1

formula_dir=/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula
cache_dir="$(brew --cache)"

if [ "$bottle_or_zip" = "bottle" ]; then
  bottle_file=$2
  bottle_filename="$(basename $bottle_file)"
  formula_file=$3
  tarball=$4
  tarball_filename="$(basename $tarball)"
  zrythm_version=$5
  carla_version=$6

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
  sed -i -e "s/@VERSION@/$zrythm_version/" \
    $formula_dir/$formula_filename
  sed -i -e "s/@VERSION@/$carla_version/" \
    $formula_dir/carla-git.rb
  sed -i -e "s/@SHA256@/$(openssl sha256 -r $tarball | awk '{print $1;}')/" \
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
  carla_git_bottle_filename="carla-git--0.1.1.catalina.bottle.tar.gz"
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
  carla_bottle_file=$5
  tmp="${zip_filename%.*}"
  mkdir -p $tmp
  rm -rf $zip_file
  if [[ "$bottle_filename" == *"rial"* ]]; then
    cp README-osx-trial.in $tmp/README
    sed -i -e "s/@TRIAL@/-trial/g" $tmp/README
  else
    cp README-osx.in $tmp/README
    sed -i -e "s/@TRIAL@//g" $tmp/README
  fi
  sed -i -e "s/@VERSION@/$zrythm_version/" \
    $tmp/README
  mkdir -p $tmp/bin
  cp $bottle_file $tmp/bin/zrythm-$zrythm_version.catalina.bottle.tar.gz
  cp $carla_bottle_file $tmp/bin/carla-git.catalina.bottle.tar.gz
  cp installer-osx.sh.in $tmp/installer.sh
  sed -i -e "s/@VERSION@/$zrythm_version/" \
    $tmp/installer.sh
  zip -r $zip_file $tmp
fi
