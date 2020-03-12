#! /bin/bash

#  Copyright (C) 2019-2020 Alexandros Theodotou <alex at zrythm dot org>

# Notes:
# 1. This script assumes you have all the dependencies
#   installed using HomeBrew.
# 2. Meant to be run from the parent dir
# 3. Uses appdmg (brew install npm, npm install -g appdmg)
# 4. need to install librsvg and then reinstall gdk-pixbuf
#   in brew to get svg support (or copy the pixbuf loader from
#   the Cellar of libtsvg to the Cellar of gdk-pixbuf)

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

ZRYTHM_VERSION=$1
ZRYTHM_SRC_DIR=$2
ZRYTHM_INSTALL_PREFIX=$3
FINAL_DMG_PATH=$4
OSX_SOURCE_DATA_DIR=$5
NORMAL_PREFIX=$6
APP_NAME_W_SPACES=$7
APP_NAME_NO_SPACES=$8
WORK_ROOT=/tmp/zrythm-dmg

rm -rf $WORK_ROOT

# setup directory structure
APPDIR=$WORK_ROOT/$APP_NAME_NO_SPACES-buf
Contents=$APPDIR/Contents
Resources=$Contents/Resources
Bin=$Resources/bin
Share=$Resources/share
Etc=$Resources/etc
Locale=$Resources/share/locale
Lib=$Resources/lib

echo "Building new app directory structure ..."
mkdir -p $Contents/MacOS
mkdir -p $Etc
mkdir -p $Locale
mkdir -p $Lib
mkdir -p $Bin

# copy static files
echo "copying plists"
sed "s/@VERSION@/$ZRYTHM_VERSION/" < \
  $OSX_SOURCE_DATA_DIR/Info.plist.in > $Contents/Info.plist
cp $Contents/Info.plist $OSX_SOURCE_DATA_DIR/Info.plist

THEMES_DIR="$Share/themes"
mkdir -p "$THEMES_DIR"
cp -RL "$NORMAL_PREFIX/share/themes/Default" "$THEMES_DIR/"

echo "copying Adwaita icons"
ICONS_DIR="$Share/icons"
mkdir -p "$ICONS_DIR"
cp -RL "$NORMAL_PREFIX/share/icons/Adwaita" "$ICONS_DIR/"

echo "copying existing hicolor icons"
cp -RL "$NORMAL_PREFIX/share/icons/hicolor" "$ICONS_DIR/"

echo "copying app icon"
APPICON_DIR1=$ICONS_DIR/hicolor/scalable/apps
APPICON_DIR2=$ICONS_DIR/hicolor/48x48/apps
mkdir -p $APPICON_DIR1
mkdir -p $APPICON_DIR2
cp $ZRYTHM_SRC_DIR/resources/icons/zrythm/zrythm.svg $APPICON_DIR1/
cp $ZRYTHM_SRC_DIR/resources/icons/zrythm/zrythm.svg $APPICON_DIR2/

SCHEMAS_DIR="glib-2.0/schemas"
mkdir -p $Share/$SCHEMAS_DIR
cp $NORMAL_PREFIX/share/$SCHEMAS_DIR/org.zrythm*.xml \
  "$Share/$SCHEMAS_DIR/"
cp $NORMAL_PREFIX/share/$SCHEMAS_DIR/org.gtk.*.xml \
  "$Share/$SCHEMAS_DIR/"
echo "building schemas"
glib-compile-schemas "$Share/$SCHEMAS_DIR/"

# add license, readme, third party info
cp $ZRYTHM_SRC_DIR/README.md $Resources/
cp $ZRYTHM_SRC_DIR/COPYING* $Resources/
brew list --versions -1 -v > $Resources/THIRDPARTY_INFO.txt

sed "s|@NORMAL_PREFIX@|$NORMAL_PREFIX|" < \
  $OSX_SOURCE_DATA_DIR/zrythm.bundle.in > $WORK_ROOT/zrythm.bundle
sed -i -e "s|@ZRYTHM_PREFIX@|$ZRYTHM_INSTALL_PREFIX|" $WORK_ROOT/zrythm.bundle
sed -i -e "s|@BUNDLE_DEST@|$WORK_ROOT|" $WORK_ROOT/zrythm.bundle
sed -i -e "s|@OSX_DATA_DIR@|$OSX_SOURCE_DATA_DIR|" $WORK_ROOT/zrythm.bundle
sed -i -e "s|@BUFFER@|$APPDIR|" $WORK_ROOT/zrythm.bundle
gtk-mac-bundler $WORK_ROOT/zrythm.bundle

# make dmg
echo "making dmg from .app"
rm -f $FINAL_DMG_PATH
mkdir -p $(dirname "$FINAL_DMG_PATH")
sed "s|@APP_PATH@|$APPDIR|" < \
  $OSX_SOURCE_DATA_DIR/appdmg.json.in > $WORK_ROOT/appdmg.json
sed -i -e "s|@APPNAME@|$APP_NAME_W_SPACES|" $WORK_ROOT/appdmg.json
sed -i -e "s|@ICNS_PATH@|$Resources/zrythm.icns|" \
  $WORK_ROOT/appdmg.json
cat $WORK_ROOT/appdmg.json
appdmg $WORK_ROOT/appdmg.json $FINAL_DMG_PATH
rm -f $WORK_ROOT/appdmg.json
echo "Done."
exit
