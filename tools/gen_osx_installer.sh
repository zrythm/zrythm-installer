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
APPDIR=$WORK_ROOT/$APP_NAME_NO_SPACES.app
Contents=$APPDIR/Contents
Resources=$Contents/Resources
Bin=$Resources/bin
Share=$Resources/share
Etc=$Resources/etc
Locale=$Resources/share/locale
Lib=$Resources/lib

echo "system dependencies:"
for file in $ZRYTHM_INSTALL_PREFIX/bin/zrythm* ; do
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

# copy static files
echo "copying plists"
sed "s/@VERSION@/$ZRYTHM_VERSION/" < \
  $OSX_SOURCE_DATA_DIR/Info.plist.in > $Contents/Info.plist

cp $OSX_SOURCE_DATA_DIR/startup_script.sh $Contents/MacOS/Zrythm
chmod 775 $Contents/MacOS/Zrythm
MAIN_EXECUTABLE=zrythm  ## used in startup_script

echo "Copying zrythm executable ...."
cp $ZRYTHM_INSTALL_PREFIX/bin/zrythm $Bin/
cp $OSX_SOURCE_DATA_DIR/zrythm.icns $Resources/

set +e # things below are not error-free (optional files etc) :(

# etc gtk
cp -RL $NORMAL_PREFIX/etc/gtk-3.0 $Etc/

# charset alias
cp -RL $NORMAL_PREFIX/lib/charset.alias $Lib/

# GDK Pixbuf
echo "copying gdk pixbuf loaders"
GDK_PIXBUF_DIR=gdk-pixbuf-2.0/2.10.0
mkdir -p $Lib/$GDK_PIXBUF_DIR
cp -RL $NORMAL_PREFIX/lib/$GDK_PIXBUF_DIR/* $Lib/$GDK_PIXBUF_DIR/

# localization
echo "copying languages"
languages="fr de it es ja"
for lang in $languages; do
  SRC_DIR=$NORMAL_PREFIX/share/locale/$lang/LC_MESSAGES
  CUR_DIR="$Locale/$lang/LC_MESSAGES"
  mkdir -p $CUR_DIR
  cp $SRC_DIR/zrythm.mo "$CUR_DIR/"
  cp $SRC_DIR/gtk30.mo $SRC_DIR/gtk30-properties.mo $CUR_DIR/
done

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

echo "copying themes"
#rsync -a --copy-links /usr/local/share/ $Share/
cp -RL "$NORMAL_PREFIX/share/themes" "$Share/"

echo "copying fonts"
cp -R $ZRYTHM_SRC_DIR/data/fonts "$Share/"
cp -R $NORMAL_PREFIX/etc/fonts "$Etc/"
sed -i -e \
  's|<dir>~/.fonts</dir>|<dir prefix="relative">../share/fonts</dir>|' $Etc/fonts/fonts.conf

SCHEMAS_DIR="glib-2.0/schemas"
mkdir -p $Share/$SCHEMAS_DIR
cp $NORMAL_PREFIX/share/$SCHEMAS_DIR/org.zrythm*.xml \
  "$Share/$SCHEMAS_DIR/"
cp $NORMAL_PREFIX/share/$SCHEMAS_DIR/org.gtk.*.xml \
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

	deps=`otool -L $file | awk '{print $1}' | egrep "($NORMAL_PREFIX|libs/$STDCPP)" | grep -v "$(basename $file)"`
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
  for lib in `otool -L $EXE | egrep "($NORMAL_PREFIX|$ZRYTHM_INSTALL_PREFIX|/opt/|/local/)" | awk '{print $1}' | grep -v 'libjack\.'` ; do
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
  for dylib in $libdir/*.dylib $libdir/*.so ; do
    # skip symlinks
    if test -L $dylib ; then
      continue
    fi
    # change all the dependencies
    changes=""
    for lib in `otool -L $dylib | egrep "($NORMAL_PREFIX|$ZRYTHM_INSTALL_PREFIX|/opt/|/local/)" | awk '{print $1}' | grep -v 'libjack\.'` ; do
      base=`basename $lib`
      if echo $lib | grep -s libbase; then
        changes="$changes -change $lib @executable_path/../$libbase/$base"
      else
        changes="$changes -change $lib @executable_path/../lib/$base"
      fi
    done
    if test "x$changes" != x ; then
      if  install_name_tool $changes $dylib ; then
        :
      else
        exit 1
      fi
    fi
    # now the change what the library thinks its own name is
    base=`basename $dylib`
    install_name_tool -id @executable_path/../$libbase/$base $dylib
  done
done

# add license, readme, third party info
cp $ZRYTHM_SRC_DIR/README.md $Resources/
cp $ZRYTHM_SRC_DIR/COPYING* $Resources/
brew list --versions -1 -v > $Resources/THIRDPARTY_INFO.txt

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
