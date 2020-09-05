#! /bin/bash

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

# $1 mingw prefix (chroot/mingw64 or /usr/x86_64-w64-mingw32)
# $2 zrythm version
# $3 build dir, this is the staging directory to use
# to stage files to - the root of the installer is in $3/dist
# $4 path to inno installer definition
# $5 App name
# $6 Plugins dir (containing *.lv2 bundles)
# $7 "-trial" or nothing

ZRYTHM_VERSION="$2"

INNO_ISS=$4
BUILD_DIR=$3
MINGW_PREFIX=$1
APP_NAME=$5
PLUGINS_DIR=$6
BREEZE_DARK_PATH=$7
manual_zip_path=$8
TRIAL=$9
DIST_DIR=$BUILD_DIR/dist # root of the distribution
DIST_BINDIR=$DIST_DIR/bin
DIST_LIBDIR=$DIST_DIR/lib
DIST_SHAREDIR=$DIST_DIR/share
DIST_ETCDIR=$DIST_DIR/etc
INSTALL_DATA="install -m 644"
GLIB_SCHEMAS_DIR_SUFFIX=share/glib-2.0/schemas

#rm -rf $BUILD_DIR
mkdir -p $DIST_BINDIR
mkdir -p $DIST_LIBDIR
mkdir -p $DIST_SHAREDIR
mkdir -p $DIST_ETCDIR

mkdir -p $DIST_DIR/$GLIB_SCHEMAS_DIR_SUFFIX
sudo glib-compile-schemas $MINGW_PREFIX/$GLIB_SCHEMAS_DIR_SUFFIX
cp $MINGW_PREFIX/$GLIB_SCHEMAS_DIR_SUFFIX/* $DIST_DIR/$GLIB_SCHEMAS_DIR_SUFFIX/

# ******************************
echo "Copying dlls..."

# --- legacy ---
DLLS=" \
  libatk-1.0-0.dll \
  libbz2-1.dll \
  libcairo-2.dll \
  libcairo-gobject-2.dll \
  libcroco-0.6-3.dll \
  libdatrie-1.dll \
  libdl.dll \
  libepoxy-0.dll \
  libexpat-1.dll \
  libffi-6.dll \
  libFLAC-8.dll \
  libfontconfig-1.dll \
  libfreetype-6.dll \
  libfribidi-0.dll \
  libgcc_s_seh-1.dll \
  libgdk_pixbuf-2.0-0.dll \
  libgdk-3-0.dll \
  libgio-2.0-0.dll \
  libglib-2.0-0.dll \
  libgmodule-2.0-0.dll \
  libgobject-2.0-0.dll \
  libgraphite2.dll \
  libgthread-2.0-0.dll \
  libgtk-3-0.dll \
  libharfbuzz-0.dll \
  libiconv-2.dll \
  libintl-8.dll \
  libjasper-4.dll \
  libjpeg-8.dll \
  liblzma-5.dll \
  libogg-0.dll \
  libpango-1.0-0.dll \
  libpangocairo-1.0-0.dll \
  libpangoft2-1.0-0.dll \
  libpangowin32-1.0-0.dll \
  libpcre-1.dll \
  libpng16-16.dll \
  libportaudio-2.dll \
  librsvg-2-2.dll \
  libsamplerate-0.dll \
  libsndfile-1.dll \
  libstdc++-6.dll \
  libthai-0.dll \
  libtiff-5.dll \
  libvorbis-0.dll \
  libvorbisenc-2.dll \
  libvorbisfile-3.dll \
  libwinpthread-1.dll \
  libxml2-2.dll \
  zlib1.dll"

#for file in $DLLS; do
  #echo "copying $file"
  #cp $MINGW_PREFIX/bin/$file $DIST_BINDIR/
#done
#cp $MINGW_PREFIX/bin/*.dll $DIST_BINDIR/
# --- end legacy ---

tools/copy-dll-deps.sh \
  --infile "$MINGW_PREFIX/bin/zrythm$TRIAL.exe" \
  --destdir $DIST_BINDIR/ \
  --recursivesrcdir "$MINGW_PREFIX/bin" \
  --srcdir "$MINGW_PREFIX/bin" \
  --objdump "/mingw64/bin/objdump.exe" \
  --copy

# some dlls need to be copied manually
cp $MINGW_PREFIX/bin/librsvg-2-2.dll $DIST_BINDIR/
cp $MINGW_PREFIX/lib/carla/*.dll $DIST_BINDIR/

# for an unknown reason it doesn't work unless it
# is named CarlaNativePlugin.dll
mv $DIST_BINDIR/libcarla_native-plugin.dll \
  $DIST_BINDIR/CarlaNativePlugin.dll

# ******************************

# ******************************
if [ "$TRIAL" != "-trial" ]; then
  echo "packaging user manuals" ;
  unzip -o $manual_zip_path -d $DIST_DIR/ ;
fi

# ******************************

# ******************************
#echo "packaging settings.ini"
#mkdir -p $DIST_ETCDIR/gtk-3.0
#cp data/settings.ini $ETC_GTK_DIR/

#cp -R $MINGW_PREFIX/etc/gtk-3.0 $MINGW_PREFIX/etc/fonts $DIST_ETCDIR
cp -R $MINGW_PREFIX/etc/fonts $DIST_ETCDIR
# ******************************

# ******************************
#echo "packaging glib schema"
#SCHEMAS_DIR="$SHAREDIR/glib-2.0/schemas"
#mkdir -p "$SCHEMAS_DIR"
#cp "$BUILD_DIR/schemas/gschemas.compiled" \
  #"$SCHEMAS_DIR/"
# ******************************

# ******************************
echo "packaging breeze icons"
mkdir -p "$DIST_SHAREDIR/icons"
# the icons are preinstalled here
cp -R "$BREEZE_DARK_PATH" "$DIST_SHAREDIR/icons"/breeze-dark
#cp -R "$MINGW_PREFIX/share/icons/Adwaita" "$DIST_SHAREDIR/icons"/
#echo "packaging breeze icons"
#cp -R "$MINGW_PREFIX/bin/data/icons/breeze-dark" "$DIST_SHAREDIR/icons/"
echo "packaging existing hicolor icons"
cp -R "$MINGW_PREFIX/share/icons/hicolor" "$DIST_SHAREDIR/icons/"
# ******************************

# ******************************
echo "packaging gtksourceview files"
cp -R $MINGW_PREFIX/share/gtksourceview-4 $DIST_SHAREDIR/
# ******************************

# ******************************
echo "packaging locales"
cp -R $MINGW_PREFIX/share/locale $DIST_SHAREDIR/
# ******************************

# ******************************
echo "packaging other assets"
cp -R $MINGW_PREFIX/share/zrythm $DIST_SHAREDIR/
# ******************************

# ******************************
echo "packaging fonts"
cp -R $MINGW_PREFIX/share/fonts $DIST_SHAREDIR/
# ******************************

# ******************************
echo "packaging gdk pixbuf loaders"
PIXBUF_DIR="lib/gdk-pixbuf-2.0/2.10.0"
mkdir -p "$DIST_DIR/$PIXBUF_DIR/loaders"
cp "$MINGW_PREFIX/$PIXBUF_DIR/loaders/"*.dll \
  "$DIST_DIR/$PIXBUF_DIR/loaders/"
#cp "$MINGW_PREFIX/$PIXBUF_DIR/loaders.cache" \
#  "$DIST_DIR/$PIXBUF_DIR/"
GDK_PIXBUF_MODULEDIR="$MINGW_PREFIX/$PIXBUF_DIR/loaders" \
  $MINGW_PREFIX/bin/gdk-pixbuf-query-loaders.exe \
  $MINGW_PREFIX/$PIXBUF_DIR/loaders/libpixbufloader-svg.dll \
  $MINGW_PREFIX/$PIXBUF_DIR/loaders/libpixbufloader-jpeg.dll \
  $MINGW_PREFIX/$PIXBUF_DIR/loaders/libpixbufloader-gif.dll \
  $MINGW_PREFIX/$PIXBUF_DIR/loaders/libpixbufloader-bmp.dll \
  $MINGW_PREFIX/$PIXBUF_DIR/loaders/libpixbufloader-tiff.dll \
  $MINGW_PREFIX/$PIXBUF_DIR/loaders/libpixbufloader-png.dll > \
  "$DIST_DIR/$PIXBUF_DIR/loaders.cache"
sed -i -e 's|.*loaders/|"lib\\\\gdk-pixbuf-2.0\\\\2.10.0\\\\loaders\\\\|g' \
  "$DIST_DIR/$PIXBUF_DIR/loaders.cache"
# ******************************

# ******************************
#echo "packaging immodules"
#IMMODULES_DIR="lib/gtk-3.0/3.0.0"
#mkdir -p "$DIST_DIR/$IMMODULES_DIR/immodules"
#cp "$PREFIX/$IMMODULES_DIR/immodules/"*.dll \
  #"$DIST_DIR/$IMMODULES_DIR/immodules/"
#cat /usr/x86_64-w64-mingw32/lib/gtk-3.0/3.0.0/immodules.cache | sed 's/\".*\/lib/lib/g' | sed 's/\/usr\/.*\/share/share/g' | sed 's/\//\\\\/g' > "$DIST_DIR/$IMMODULES_DIR/immodules.cache"
# ******************************

# ******************************
echo "packaging binaries"
cp "$MINGW_PREFIX/bin/zrythm$TRIAL.exe" "$DIST_BINDIR/zrythm.exe"
cp $MINGW_PREFIX/bin/carla*.exe "$DIST_BINDIR/"
if [ -f "$MINGW_PREFIX/bin/gdbus.exe" ]; then
  cp "$MINGW_PREFIX/bin/gdbus.exe" "$DIST_BINDIR/"
fi
chmod +x $BUILD_DIR/rcedit-x64.exe
$BUILD_DIR/rcedit-x64.exe "$DIST_BINDIR/zrythm.exe" --set-icon  "$DIST_DIR/zrythm.ico"
cp "$MINGW_PREFIX/bin/gspawn-win64-helper.exe" "$DIST_BINDIR/"
cp "$MINGW_PREFIX/bin/gspawn-win64-helper-console.exe" "$DIST_BINDIR/"
#cp "$MINGW_PREFIX/bin/gdbus.exe" "$DIST_BINDIR/"
# ******************************

cp "$INNO_ISS" "$DIST_DIR"/
cd $DIST_DIR
~/.wine/drive_c/Program\ Files\ \(x86\)/Inno\ Setup\ 6/ISCC.exe \
  "//DAppName=$APP_NAME" "//DAppVersion=$ZRYTHM_VERSION" \
  "//DAppInfoVersion=${ZRYTHM_VERSION:0:7}" \
  "//DPluginsDir=$PLUGINS_DIR" \
  installer.iss