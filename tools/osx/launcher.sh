#!/bin/sh

name=`basename "$0"`
tmp="$0"
tmp=`dirname "$tmp"`
tmp=`dirname "$tmp"`
bundle=`dirname "$tmp"`
bundle_contents="$bundle"/Contents
bundle_macos="$bundle_contents"/MacOS
bundle_res="$bundle_contents"/Resources
bundle_lib="$bundle_res"/lib
bundle_bin="$bundle_res"/bin
bundle_data="$bundle_res"/share
bundle_etc="$bundle_res"/etc

export PREFIX="$bundle_res"
export DYLD_LIBRARY_PATH="$bundle_lib"
export XDG_CONFIG_DIRS="$bundle_etc"/xdg
# don't use XDG_DATA_DIRS because zrythm tries to create
# the zrythm dir inside that
#export XDG_DATA_DIRS="$bundle_data"
export GSETTINGS_SCHEMA_DIR=$bundle_data/glib-2.0/schemas
export GTK_DATA_PREFIX="$bundle_res"
export GTK_EXE_PREFIX="$bundle_res"
export GTK_PATH="$bundle_res"

export GDK_PIXBUF_MODULE_FILE="$bundle_lib/gdk-pixbuf-2.0/2.10.0/loaders.cache"
export GDK_PIXBUF_MODULEDIR="$bundle_lib/gdk-pixbuf-2.0/2.10.0/loaders"

I18NDIR="$bundle_data/locale"

# set language
defaults read zrythm /org/zrythm/Zrythm/preferences/language
if [[ $? == 0 ]]; then
  PREFERENCES_LANG=`defaults read zrythm /org/zrythm/Zrythm/preferences/language`
  export LANG="$PREFERENCES_LANG"
  export LC_MESSAGES="$PREFERENCES_LANG"
fi

# Strip out the argument added by the OS.
if /bin/expr "x$1" : '^x-psn_' > /dev/null; then
  shift 1
fi

export GDK_DEBUG=interactive

exec "$bundle_bin/zrythm" "$@"
