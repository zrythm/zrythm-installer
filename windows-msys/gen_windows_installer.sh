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

zrythm_version="$2"

inno_iss=$4
build_dir=$3
mingw_prefix=$1
app_name=$5
plugins_dir=$6
breeze_dark_path=$7
manual_zip_path=$8
trial=$9
dist_dir=$build_dir/dist # root of the distribution
dist_bindir=$dist_dir/bin
dist_libdir=$dist_dir/lib
dist_sharedir=$dist_dir/share
dist_etcdir=$dist_dir/etc
install_data="install -m 644"
glib_schemas_dir_suffix=share/glib-2.0/schemas

#rm -rf $build_dir
mkdir -p $dist_bindir
mkdir -p $dist_libdir
mkdir -p $dist_sharedir
mkdir -p $dist_etcdir

mkdir -p $dist_dir/$glib_schemas_dir_suffix
sudo glib-compile-schemas $mingw_prefix/$glib_schemas_dir_suffix
cp $mingw_prefix/$glib_schemas_dir_suffix/* $dist_dir/$glib_schemas_dir_suffix/

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
  #cp $mingw_prefix/bin/$file $dist_bindir/
#done
#cp $mingw_prefix/bin/*.dll $dist_bindir/
# --- end legacy ---

tools/copy-dll-deps.sh \
  --infile "$mingw_prefix/bin/zrythm$trial.exe" \
  --destdir $dist_bindir/ \
  --recursivesrcdir "$mingw_prefix/bin" \
  --srcdir "$mingw_prefix/bin" \
  --objdump "/mingw64/bin/objdump.exe" \
  --copy

# some dlls need to be copied manually
cp $mingw_prefix/bin/librsvg-2-2.dll $dist_bindir/
cp $mingw_prefix/lib/carla/*.dll $dist_bindir/

# for an unknown reason it doesn't work unless it
# is named CarlaNativePlugin.dll
mv $dist_bindir/libcarla_native-plugin.dll \
  $dist_bindir/CarlaNativePlugin.dll

# ******************************

# ******************************
if [ "$trial" != "-trial" ]; then
  echo "packaging user manuals" ;
  unzip -o $manual_zip_path -d $dist_dir/ ;
fi

# ******************************

# ******************************
#echo "packaging settings.ini"
#mkdir -p $dist_etcdir/gtk-3.0
#cp data/settings.ini $ETC_GTK_DIR/

#cp -R $mingw_prefix/etc/gtk-3.0 $mingw_prefix/etc/fonts $dist_etcdir
cp -R $mingw_prefix/etc/fonts $dist_etcdir
# ******************************

# ******************************
#echo "packaging glib schema"
#SCHEMAS_DIR="$SHAREDIR/glib-2.0/schemas"
#mkdir -p "$SCHEMAS_DIR"
#cp "$build_dir/schemas/gschemas.compiled" \
  #"$SCHEMAS_DIR/"
# ******************************

# ******************************
echo "packaging breeze icons"
mkdir -p "$dist_sharedir/icons"
# the icons are preinstalled here
cp -R "$breeze_dark_path" "$dist_sharedir/icons"/breeze-dark
#cp -R "$mingw_prefix/share/icons/Adwaita" "$dist_sharedir/icons"/
#echo "packaging breeze icons"
#cp -R "$mingw_prefix/bin/data/icons/breeze-dark" "$dist_sharedir/icons/"
echo "packaging existing hicolor icons"
cp -R "$mingw_prefix/share/icons/hicolor" "$dist_sharedir/icons/"
# ******************************

# ******************************
echo "packaging gtksourceview files"
cp -R $mingw_prefix/share/gtksourceview-4 $dist_sharedir/
# ******************************

# ******************************
echo "packaging locales"
cp -R $mingw_prefix/share/locale $dist_sharedir/
# ******************************

# ******************************
echo "packaging other assets"
cp -R $mingw_prefix/share/zrythm $dist_sharedir/
# ******************************

# ******************************
echo "packaging fonts"
cp -R $mingw_prefix/share/fonts $dist_sharedir/
# ******************************

# ******************************
echo "packaging gdk pixbuf loaders"
PIXBUF_DIR="lib/gdk-pixbuf-2.0/2.10.0"
mkdir -p "$dist_dir/$PIXBUF_DIR/loaders"
cp "$mingw_prefix/$PIXBUF_DIR/loaders/"*.dll \
  "$dist_dir/$PIXBUF_DIR/loaders/"
#cp "$mingw_prefix/$PIXBUF_DIR/loaders.cache" \
#  "$dist_dir/$PIXBUF_DIR/"
GDK_PIXBUF_MODULEDIR="$mingw_prefix/$PIXBUF_DIR/loaders" \
  $mingw_prefix/bin/gdk-pixbuf-query-loaders.exe \
  $mingw_prefix/$PIXBUF_DIR/loaders/libpixbufloader-svg.dll \
  $mingw_prefix/$PIXBUF_DIR/loaders/libpixbufloader-jpeg.dll \
  $mingw_prefix/$PIXBUF_DIR/loaders/libpixbufloader-gif.dll \
  $mingw_prefix/$PIXBUF_DIR/loaders/libpixbufloader-bmp.dll \
  $mingw_prefix/$PIXBUF_DIR/loaders/libpixbufloader-tiff.dll \
  $mingw_prefix/$PIXBUF_DIR/loaders/libpixbufloader-png.dll > \
  "$dist_dir/$PIXBUF_DIR/loaders.cache"
sed -i -e 's|.*loaders/|"lib\\\\gdk-pixbuf-2.0\\\\2.10.0\\\\loaders\\\\|g' \
  "$dist_dir/$PIXBUF_DIR/loaders.cache"
# ******************************

# ******************************
#echo "packaging immodules"
#IMMODULES_DIR="lib/gtk-3.0/3.0.0"
#mkdir -p "$dist_dir/$IMMODULES_DIR/immodules"
#cp "$PREFIX/$IMMODULES_DIR/immodules/"*.dll \
  #"$dist_dir/$IMMODULES_DIR/immodules/"
#cat /usr/x86_64-w64-mingw32/lib/gtk-3.0/3.0.0/immodules.cache | sed 's/\".*\/lib/lib/g' | sed 's/\/usr\/.*\/share/share/g' | sed 's/\//\\\\/g' > "$dist_dir/$IMMODULES_DIR/immodules.cache"
# ******************************

# ******************************
echo "packaging binaries"
cp "$mingw_prefix/bin/zrythm$trial.exe" "$dist_bindir/zrythm.exe"
cp $mingw_prefix/bin/carla*.exe "$dist_bindir/"
if [ -f "$mingw_prefix/bin/gdbus.exe" ]; then
  cp "$mingw_prefix/bin/gdbus.exe" "$dist_bindir/"
fi
chmod +x $build_dir/rcedit-x64.exe
$build_dir/rcedit-x64.exe "$dist_bindir/zrythm.exe" --set-icon  "$dist_dir/zrythm.ico"
cp "$mingw_prefix/bin/gspawn-win64-helper.exe" "$dist_bindir/"
cp "$mingw_prefix/bin/gspawn-win64-helper-console.exe" "$dist_bindir/"
#cp "$mingw_prefix/bin/gdbus.exe" "$dist_bindir/"
# ******************************

cp "$inno_iss" "$dist_dir"/
info_version=`echo "$zrythm_version" | sed -e 's/^\([0-9]\+\.[0-9]\+\.[0-9]\+\)\..*$/\1/'`
cd $dist_dir
~/.wine/drive_c/Program\ Files\ \(x86\)/Inno\ Setup\ 6/ISCC.exe \
  "//DAppName=$app_name" "//DAppVersion=$zrythm_version" \
  "//DAppInfoVersion=$info_version" \
  "//DPluginsDir=$plugins_dir" \
  installer.iss
