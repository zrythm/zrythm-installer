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

# Notes:
# 1. This script assumes you have all the dependencies
#   installed using HomeBrew.
# 2. Meant to be run from the parent dir
# 3. Uses appdmg (brew install npm, npm install -g appdmg)
# 4. need to install librsvg and then reinstall gdk-pixbuf
#   in brew to get svg support (or copy the pixbuf loader from
#   the Cellar of libtsvg to the Cellar of gdk-pixbuf) OR just install adwaita-icon-theme which
# installs both
# 5. do a `brew remove adwaita-icon-theme gtk+3 librsvg yelp-tools gdk-pixbuf` when done to check
# if it loads without these

# args:
# 1: version
# 2: zrythm source root dir
# 3: prefix where zrythm was installed
# 4: path to copy finished installer to
# 5: osx data dir (tools/osx)
# 6: normal prefix (where other programs are installed)
# 7: App name Zrythm or Zrythm (Trial)
# 8: App name Zrythm or Zrythm-trial

set -e

zrythm_version=$1
zrythm_src_dir=$2
zrythm_install_prefix=$3
FINAL_DMG_PATH=$4
OSX_SOURCE_DATA_DIR=$5
normal_prefix=$6
app_name_w_spaces=$7
APP_NAME_NO_SPACES=$8
breeze_dark_path=$9
manual_zip_path=${10}
WORK_ROOT=/tmp/zrythm-dmg

rm -rf $WORK_ROOT

# setup directory structure
APPDIR=$WORK_ROOT/$APP_NAME_NO_SPACES.app
Contents=$APPDIR/Contents
Resources=$Contents/Resources
Bin=$Resources/bin
Share=$Resources/share
Doc=$Resources/doc
Etc=$Resources/etc
Locale=$Resources/share/locale
Lib=$Resources/lib

echo "system dependencies:"
for file in $zrythm_install_prefix/bin/zrythm* ; do
	if ! file $file | grep -qs Mach-O ; then
	    continue
	fi
	otool -L $file | awk '{print $1}' | egrep -v "(^$WORK_ROOT*)"
    done | sort | uniq

echo "Removing old $APPDIR tree ..."
rm -rf $APPDIR

echo "Building new app directory structure ..."
mkdir -p $Contents/MacOS
mkdir -p $Etc
mkdir -p $Locale
mkdir -p $Lib
mkdir -p $Bin
mkdir -p $Doc

# copy static files
echo "copying plists"
sed "s/@VERSION@/$zrythm_version/" < \
  $OSX_SOURCE_DATA_DIR/Info.plist.in > $Contents/Info.plist

cp $OSX_SOURCE_DATA_DIR/launcher.sh $Contents/MacOS/Zrythm
chmod 775 $Contents/MacOS/Zrythm
MAIN_EXECUTABLE=zrythm  ## used in startup_script

echo "Copying zrythm executable ...."
cp $zrythm_install_prefix/bin/zrythm $Bin/
cp $OSX_SOURCE_DATA_DIR/zrythm.icns $Resources/

set +e

# etc gtk
cp -RL $normal_prefix/etc/gtk-3.0 $Etc/

# charset alias
cp -RL $normal_prefix/lib/charset.alias $Lib/

# GDK Pixbuf
echo "copying gdk pixbuf loaders"
GDK_PIXBUF_DIR=gdk-pixbuf-2.0/2.10.0
mkdir -p $Lib/$GDK_PIXBUF_DIR
cp -RL $normal_prefix/lib/$GDK_PIXBUF_DIR/* $Lib/$GDK_PIXBUF_DIR/
cp -RL $normal_prefix/lib/librsvg*.dylib $Lib/

# Carla
cp -RL $zrythm_install_prefix/lib/zrythm/lib/carla $Lib/
cp -RL $zrythm_install_prefix/lib/zrythm/lib/carla/*.dylib $Lib/
cp $zrythm_install_prefix/lib/zrythm/lib/carla/carla-discovery-native $Bin/

# localization
echo "copying languages"
languages="fr de it es ja"
for lang in $languages; do
  CUR_DIR="$Locale/$lang/LC_MESSAGES"
  mkdir -p $CUR_DIR
  _src_dir=$zrythm_install_prefix/share/locale/$lang/LC_MESSAGES
  cp $_src_dir/zrythm.mo "$CUR_DIR/"
  _src_dir=$normal_prefix/share/locale/$lang/LC_MESSAGES
  cp $_src_dir/gtk30.mo $_src_dir/gtk30-properties.mo $CUR_DIR/
done

echo "copying zrythm resoures"
cp -RL "$zrythm_install_prefix/share/zrythm" "$Share/"

echo "copying breeze icons"
ICONS_DIR="$Share/icons"
mkdir -p "$ICONS_DIR"
cp -RL "$breeze_dark_path" "$ICONS_DIR/breeze-dark"

echo "copying existing hicolor icons"
cp -RL "$normal_prefix/share/icons/hicolor" "$ICONS_DIR/"

echo "copying app icon"
APPICON_DIR1=$ICONS_DIR/hicolor/scalable/apps
APPICON_DIR2=$ICONS_DIR/hicolor/48x48/apps
mkdir -p $APPICON_DIR1
mkdir -p $APPICON_DIR2
cp $zrythm_src_dir/data/icon-themes/zrythm-dark/scalable/apps/zrythm.svg $APPICON_DIR1/
cp $zrythm_src_dir/data/icon-themes/zrythm-dark/scalable/apps/zrythm.svg $APPICON_DIR2/

echo "copying themes"
#rsync -a --copy-links /usr/local/share/ $Share/
cp -RL "$normal_prefix/share/themes" "$Share/"

echo "copying fonts"
cp -R $zrythm_src_dir/data/fonts "$Share/"
cp -R $normal_prefix/etc/fonts "$Etc/"
sed -i -e \
  's|<dir>~/.fonts</dir>|<dir prefix="relative">../share/fonts</dir>|' $Etc/fonts/fonts.conf

SCHEMAS_DIR="glib-2.0/schemas"
mkdir -p $Share/$SCHEMAS_DIR
cp $zrythm_install_prefix/share/$SCHEMAS_DIR/org.zrythm*.xml \
  "$Share/$SCHEMAS_DIR/"
cp $normal_prefix/share/$SCHEMAS_DIR/org.gtk.*.xml \
  "$Share/$SCHEMAS_DIR/"
echo "building schemas"
glib-compile-schemas "$Share/$SCHEMAS_DIR/"

# copy libs
STDCPP='|libstdc\+\+'
while [ true ] ; do
    missing=false
    for file in $Bin/* $Lib/* ; do
	if ! file $file | grep -qs Mach-O ; then
	    continue
	fi
	# libffi contains "S" (other section symbols) that should not be stripped.
	if [[ $file == *"libffi"* ]] ; then
	    continue
	fi

	if test x$STRIP != x ; then
		strip -u -r -arch all $file &>/dev/null
	fi

	deps=`otool -L $file | awk '{print $1}' | egrep "($normal_prefix|libs/$STDCPP)" | grep -v "$(basename $file)"`
  echo "deps=$deps"
	# echo -n "."
	for dep in $deps ; do
    echo "dependency $dep"
	    base=`basename $dep`
	    if ! test -f $Lib/$base; then
		if echo $dep | grep -sq '^libs' ; then
		    cp $WORK_ROOT/$dep $Lib
		else
		    cp -L $dep $Lib
		fi
		missing=true
	    fi
	done
    done
    if test x$missing = xfalse ; then
	# everything has been found
	break
    fi
done

# fix binary/library paths
executables="$(ls $Bin)"
for exe in $executables; do
  echo "processing executable $exe"
  EXE=$Bin/$exe
  changes=""
  for lib in `otool -L $EXE | egrep "($normal_prefix|$zrythm_install_prefix|/opt/|/local/)" | awk '{print $1}' | grep -v 'libjack\.'` ; do
    base=`basename $lib`
    changes="$changes -change $lib @executable_path/../lib/$base"
  done
  if test "x$changes" != "x" ; then
      install_name_tool $changes $EXE
  fi
done

# now do the same for all the libraries we include
echo "Fixing up library names ..."
for libdir in $Lib ; do
  libbase=`basename $libdir`
  for dylib in $(find $libdir -name '*.dylib' -o -name '*.so') ; do
    # skip symlinks
    if test -L $dylib ; then
      continue
    fi
    # change all the dependencies
    changes=""
    for lib in `otool -L $dylib | egrep "($normal_prefix|$zrythm_install_prefix|/opt/|/local/)" | awk '{print $1}' | grep -v 'libjack\.'` ; do
      base=`basename $lib`
      if echo $lib | grep -s libbase; then
        changes="$changes -change $lib @executable_path/../$libbase/$base"
      else
        changes="$changes -change $lib @executable_path/../lib/$base"
      fi
    done
    if test "x$changes" != x ; then
      echo "processing $dylib"
      chmod +w $dylib
      if  install_name_tool $changes $dylib ; then
        :
      else
        exit 1
      fi
      echo "done processing $dylib: $changes"
    fi
    # now the change what the library thinks its own name is
    base=`basename $dylib`
    install_name_tool -id @executable_path/../$libbase/$base $dylib
  done
done

# change pixbuf loader paths
sed -i -e "s|/usr/local|@executable_path/..|" $Lib/$GDK_PIXBUF_DIR/loaders.cache

# add license, readme, third party info
cp $zrythm_src_dir/README.md $Doc/
cp -r $zrythm_src_dir/LICENSES $Doc/
brew list --versions -1 -v > $Doc/THIRDPARTY_INFO.txt

# remove unnecessary files
rm -f $Lib/$GDK_PIXBUF_DIR/loaders/*.a
rm $Lib/$GDK_PIXBUF_DIR/loaders.cache-e

# make dmg
echo "making dmg from .app"
rm -f $FINAL_DMG_PATH
mkdir -p $(dirname "$FINAL_DMG_PATH")
sed "s|@APP_PATH@|$APPDIR|" < \
  $OSX_SOURCE_DATA_DIR/appdmg.json.in > $WORK_ROOT/appdmg.json
sed -i -e "s|@APPNAME@|$app_name_w_spaces|" $WORK_ROOT/appdmg.json
sed -i -e "s|@ICNS_PATH@|$Resources/zrythm.icns|" \
  $WORK_ROOT/appdmg.json
cat $WORK_ROOT/appdmg.json
appdmg $WORK_ROOT/appdmg.json $FINAL_DMG_PATH
rm -f $WORK_ROOT/appdmg.json
echo "Done."
exit
