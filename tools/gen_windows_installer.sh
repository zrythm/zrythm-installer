#! /bin/bash

#  Copyright (C) 2019-2020 Alexandros Theodotou <alex at zrythm dot org>
#
#  This file is part of Zrythm
#
#  Zrythm is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  Zrythm is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with Zrythm.  If not, see <https://www.gnu.org/licenses/>.
#

# $1 mingw prefix (chroot/mingw64)
# $2 zrythm version
# $3 build dir, this is the staging directory to use
# to stage files to - the root of the installer is in $3/dist
# $4 path to inno installer definition
# $5 App name

ZRYTHM_VERSION="$2"

INNO_ISS=$4
BUILD_DIR=$3
MINGW_PREFIX=$1
APP_NAME=$5
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
cp $MINGW_PREFIX/$GLIB_SCHEMAS_DIR_SUFFIX/* $DIST_DIR/$GLIB_SCHEMAS_DIR_SUFFIX/

# ******************************
echo "Copying dlls..."
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
cp $MINGW_PREFIX/bin/*.dll $DIST_BINDIR/

# ******************************

# ******************************
#echo "packaging settings.ini"
#mkdir -p $DIST_ETCDIR/gtk-3.0
#cp data/settings.ini $ETC_GTK_DIR/

cp -R $MINGW_PREFIX/etc/gtk-3.0 $MINGW_PREFIX/etc/fonts $DIST_ETCDIR
# ******************************

# ******************************
#echo "packaging glib schema"
#SCHEMAS_DIR="$SHAREDIR/glib-2.0/schemas"
#mkdir -p "$SCHEMAS_DIR"
#cp "$BUILD_DIR/schemas/gschemas.compiled" \
  #"$SCHEMAS_DIR/"
# ******************************

# ******************************
echo "packaging Adwaita icons"
mkdir -p "$DIST_SHAREDIR/icons"
cp -R "$MINGW_PREFIX/share/icons/Adwaita" "$DIST_SHAREDIR/icons/"
#echo "packaging breeze icons"
#cp -R "$MINGW_PREFIX/bin/data/icons/breeze-dark" "$DIST_SHAREDIR/icons/"
echo "packaging existing hicolor icons"
cp -R "$MINGW_PREFIX/share/icons/hicolor" "$DIST_SHAREDIR/icons/"
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
cp "$MINGW_PREFIX/$PIXBUF_DIR/loaders.cache" \
  "$DIST_DIR/$PIXBUF_DIR/"
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
echo "packaging zrythm.exe"
cp "$MINGW_PREFIX/bin/zrythm.exe" "$DIST_BINDIR/"
cp "$MINGW_PREFIX/bin/zrythm_vst_check.exe" "$DIST_BINDIR/"
$BUILD_DIR/rcedit-x64.exe "$DIST_BINDIR/zrythm.exe" --set-icon  "$DIST_DIR/zrythm.ico"
$BUILD_DIR/rcedit-x64.exe "$DIST_BINDIR/zrythm_vst_check.exe" --set-icon  "$DIST_DIR/zrythm.ico"
# ******************************

cp "$INNO_ISS" "$DIST_DIR"/
cd $DIST_DIR
/c/Program\ Files\ \(x86\)/Inno\ Setup\ 6/ISCC.exe "//DAppName=$APP_NAME" "//DAppVersion=$ZRYTHM_VERSION" \
  installer.iss

exit 0

# ----------- IGNORE BELOW ------------
# ******************************
# original taken from ardour/tools/x-win/package.sh
# no license header, but ardour itself is GPLv2+
echo "Preparing Windows Installer"
cp -R $NSIS_DIR $DIST_DIR/
cd $DIST_DIR
NSISFILE=zrythm.nsis
PROGRAM_NAME=Zrythm
PROGRAM_KEY=Zrythm
major_version=${PROGRAM_VERSION:0:1}
PRODUCT_ID=${PROGRAM_NAME}
PRODUCT_EXE=zrythm.exe
PRODUCT_ICON=zrythm.ico
OUTFILE="Install_v$PROGRAM_VERSION.exe"
ZRYTHMDATE=$(date -R)
STATEFILE_SUFFIX=zpj # project file
QUICKZIP=1

if [[ $MINGW_PREFIX == *"mingw64"* ]]; then
	PGF=PROGRAMFILES64
	SFX=
  WARCH=w64
else
	PGF=PROGRAMFILES
	# TODO we should only add this for 32bit on 64bit windows!
	SFX=" (x86)"
  WARCH=w32
fi

if test -n "$QUICKZIP" ; then
	cat > $NSISFILE << EOF
SetCompressor zlib
EOF
else
	cat > $NSISFILE << EOF
SetCompressor /SOLID lzma
SetCompressorDictSize 32
EOF
fi

cat >> $NSISFILE << EOF
!addincludedir "nsis\Include"
!addplugindir "nsis\Plugins"
!include MUI2.nsh
!include FileAssociation.nsh
!include WinVer.nsh

Name "${PROGRAM_NAME}"
OutFile "${OUTFILE}"
RequestExecutionLevel admin
InstallDir "\$${PGF}\\${PRODUCT_ID}"
InstallDirRegKey HKLM "Software\\${PRODUCT_NAME}\\${PRODUCT_ID}\\$WARCH" "Install_Dir"
!define MUI_ICON "${PRODUCT_ICON}"

EOF

cat >> $NSISFILE << EOF
!define MUI_FINISHPAGE_TITLE "Welcome to Zrythm"
!define MUI_FINISHPAGE_TEXT "Thank you for installing Zrythm.\$\\r\$\\nIf you would like to join the discussion, Zrythm has an IRC, Matrix and Discord chatroom.\$\\r\$\\n\$\\r\$\\nPlease visit the website below to find out more."
!define MUI_FINISHPAGE_LINK "Zrythm website"
!define MUI_FINISHPAGE_LINK_LOCATION "https://www.zrythm.org/"
#this would run as admin - see http://forums.winamp.com/showthread.php?t=353366
#!define MUI_FINISHPAGE_RUN "\$INSTDIR\\bin\\${PRODUCT_EXE}"
!define MUI_FINISHPAGE_NOREBOOTSUPPORT
EOF

cat >> $NSISFILE << EOF
!define MUI_ABORTWARNING
!insertmacro MUI_PAGE_LICENSE "COPYING"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_LANGUAGE "English"

Section "${PROGRAM_NAME} v${PROGRAM_VERSION} (required)" SecMainProg
  SectionIn RO
  SetOutPath \$INSTDIR
  File /r bin
  File /r COPYING
  File /r COPYING.GPL3
  File /r THANKS
  File /r TRANSLATORS
  File /r CONTRIBUTING.md
  File /r CHANGELOG.md
  File /r README.md
  File /r AUTHORS
  File /r lib
  File /r share
  File /r THIRDPARTY_INFO
  File /r etc
  WriteRegStr HKLM "Software\\${PROGRAM_KEY}\\v${major_version}\\$WARCH" "Install_Dir" "\$INSTDIR"
  WriteRegStr HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\${PRODUCT_ID}-${WARCH}" "DisplayName" "${PROGRAM_NAME}"
  WriteRegStr HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\${PRODUCT_ID}-${WARCH}" "UninstallString" '"\$INSTDIR\\uninstall.exe"'
  WriteRegDWORD HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\${PRODUCT_ID}-${WARCH}" "NoModify" 1
  WriteRegDWORD HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\${PRODUCT_ID}-${WARCH}" "NoRepair" 1
  WriteUninstaller "\$INSTDIR\uninstall.exe"
  CreateShortCut "\$INSTDIR\\${PROGRAM_NAME}.lnk" "\$INSTDIR\\bin\\${PRODUCT_EXE}" "" "\$INSTDIR\\bin\\${PRODUCT_EXE}" 0
  \${registerExtension} "\$INSTDIR\\bin\\zrythm" ".${STATEFILE_SUFFIX}" "${PROGRAM_NAME} Session"
  SetOutPath "\$WINDIR\\Fonts"
  File /r share\\fonts\\zrythm\\DSEG14-Classic-MINI\\DSEG14ClassicMini-Italic.ttf
  WriteRegStr HKLM "Software\\Microsoft\\Windows NT\\CurrentVersion\\Fonts" "DSEG14 Classic MINI (TrueType)" "DSEG14ClassicMini-Italic.ttf"
  SetOutPath \$INSTDIR
SectionEnd

EOF

cat >> $NSISFILE << EOF
Section "Start Menu Shortcuts" SecMenu
  SetShellVarContext all
  CreateDirectory "\$SMPROGRAMS\\${PRODUCT_ID}${SFX}"
  CreateShortCut "\$SMPROGRAMS\\${PRODUCT_ID}${SFX}\\${PROGRAM_NAME}.lnk" "\$INSTDIR\\bin\\${PRODUCT_EXE}" "" "\$INSTDIR\\bin\\${PRODUCT_EXE}" 0
EOF

cat >> $NSISFILE << EOF
  CreateShortCut "\$SMPROGRAMS\\${PRODUCT_ID}${SFX}\\Uninstall.lnk" "\$INSTDIR\\uninstall.exe" "" "\$INSTDIR\\uninstall.exe" 0
SectionEnd
LangString DESC_SecMainProg \${LANG_ENGLISH} "${PROGRAM_NAME} v${PROGRAM_VERSION}\$\\r\$\\n${ZRYTHMDATE}"
EOF

cat >> $NSISFILE << EOF
LangString DESC_SecMenu \${LANG_ENGLISH} "Create Start-Menu Shortcuts (recommended)."
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT \${SecMainProg} \$(DESC_SecMainProg)
EOF

cat >> $NSISFILE << EOF
!insertmacro MUI_DESCRIPTION_TEXT \${SecMenu} \$(DESC_SecMenu)
!insertmacro MUI_FUNCTION_DESCRIPTION_END
Section "Uninstall"
  SetShellVarContext all
  DeleteRegKey HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\${PRODUCT_ID}-${WARCH}"
  DeleteRegKey HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\${PRODUCT_ID}"
  DeleteRegKey HKLM "Software\\${PROGRAM_KEY}\\v${major_version}"
  DeleteRegKey HKLM "Software\\${PROGRAM_KEY}\\v${major_version}"
  RMDir /r "\$INSTDIR\\bin"
  RMDir /r "\$INSTDIR\\lib"
  RMDir /r "\$INSTDIR\\share"
  RMDir /r "\$INSTDIR\\etc"
  Delete "\$INSTDIR\\COPYING"
  Delete "\$INSTDIR\\COPYING.GPL3"
  Delete "\$INSTDIR\\THANKS"
  Delete "\$INSTDIR\\TRANSLATORS"
  Delete "\$INSTDIR\\CONTRIBUTING.md"
  Delete "\$INSTDIR\\CHANGELOG.md"
  Delete "\$INSTDIR\\README.md"
  Delete "\$INSTDIR\\AUTHORS"
  Delete "\$INSTDIR\\THIRDPARTY_INFO"
  Delete "\$INSTDIR\\uninstall.exe"
  Delete "\$INSTDIR\\${PROGRAM_NAME}.lnk"
  RMDir "\$INSTDIR"
  Delete "\$SMPROGRAMS\\${PRODUCT_ID}${SFX}\\*.*"
  RMDir "\$SMPROGRAMS\\${PRODUCT_ID}${SFX}"
  \${unregisterExtension} ".${STATEFILE_SUFFIX}" "${PROGRAM_NAME} Session"
  DeleteRegValue HKLM "Software\\Microsoft\\Windows NT\\CurrentVersion\\Fonts" "DSEG14 Classic MINI (TrueType)"
SectionEnd


Function .onInit

  ReadRegStr \$R0 HKLM \
    "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\${PRODUCT_ID}-${WARCH}" \
    "UninstallString"
  StrCmp \$R0 "" done

  MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION \
    "${PROGRAM_NAME} is already installed. Click 'OK' to remove the previous version or 'Cancel' to cancel this upgrade." \
    IDOK uninst
    Abort

  uninst:
    ClearErrors
    ExecWait '\$R0 _?=\$INSTDIR'
    IfErrors uninstall_error

    ReadRegStr \$R1 HKLM \
      "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\${PRODUCT_ID}-${WARCH}" \
      "UninstallString"
    StrCmp \$R1 "" 0 done

    Delete "\$INSTDIR\\uninstall.exe"
    RMDir "\$INSTDIR"
    goto done

  uninstall_error:

    MessageBox MB_OK|MB_ICONEXCLAMATION \
      "Uninstaller did not complete successfully. Continue at your own risk..." \
      IDOK done

  done:

FunctionEnd

Function .onInstSuccess

  \${If} \${AtMostWinXP}
    goto endportaudio
  \${EndIf}

  endportaudio:

FunctionEnd
EOF

rm -f ${OUTFILE}
echo " === OutFile: $OUTFILE"

if test -n "$QUICKZIP" ; then
echo " === Building Windows Installer (fast zip)"
else
echo " === Building Windows Installer (lzma compression takes ages)"
fi
time makensis -V2 $NSISFILE
ls -lgGh "$OUTFILE"

cd $src_dir
