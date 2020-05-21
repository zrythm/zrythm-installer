#! /bin/bash

set -e

# args:
# 1: zrythm version
# 2: installer zip filename
# 3: `-trial` if trial, otherwise empty

ZRYTHM_VERSION=$1
INSTALLER_ZIP_FILE=$2
TRIAL=$3
ZPLUGINS_VERSION=$4
DISTROS="archlinux debian10 ubuntu1804 ubuntu1910 ubuntu2004 fedora32"

rm $INSTALLER_ZIP_FILE

is_trial () {
  [ $TRIAL = "-trial" ]
}

copy_plugins () {
  distro=$1
  src_dir=artifacts/$distro/zplugins
  dest_dir=bin/$distro/zplugins
  mkdir -p $dest_dir

  # copy common
  for plugin in ZCompressorSP.lv2 ZLimiterSP.lv2 ZPhaserSP.lv2 ZSaw.lv2 ZVerbSP.lv2 ; do
    cp -Rf $src_dir/$plugin $dest_dir/
  done

  # copy remaining if not trial
  if !is_trial ; then
    for plugin in ZChordz.lv2 ZLFO.lv2 ; do
      cp -Rf $src_dir/$plugin $dest_dir/
    done
  fi
}

# returns the built package filename
get_package_filename () {
  search_str=""
  distro=$1
  case "$distro" in
    "debian10" | "ubuntu"*)
      search_str="DEBIAN"
      ;;
    "archlinux")
      search_str="ARCH"
    "fedora32")
      search_str="FEDORA32"
  esac
  if is_trial ; then
    echo "$(cd zrythm-installer && make pkg-trial-filename-$search_str)"
  else
    echo "$(cd zrythm-installer && make pkg-filename-$search_str)"
  fi
}

# returns the filename to be placed inside "bin"
get_dest_package_filename () {
  prefix="zrythm-$ZRYTHM_VERSION"
  distro=$1
  res=""
  case "$distro" in
    "debian10" | "ubuntu"*)
      res="$prefix-1_amd64.deb"
      ;;
    "archlinux")
      res="$prefix-1_x86_64.pkg.tar.xz"
      ;;
    "fedora32")
      res="$prefix-1_x86_64.rpm"
  esac
  echo $res
}

copy_package () {
  distro=$1
  src_pkg_file=get_package_filename $distro
  dest_pkg_file=get_dest_package_filename $distro
  cp "artifacts/$distro/$pkg_file" "bin/$distro/$dest_pkg_file"
}

# remove prev backup
rm -rf bin.bak
mv bin bin.bak || true

for distro in $DISTROS ; do
  mkdir -p bin/$distro
  copy_plugins $distro
  copy_package $distro
done

#cp artifacts/debian9/Zrythm$(2)-$(ZRYTHM_PKG_VERSION)-x86_64.AppImage \
  #Zrythm$(2)-$(ZRYTHM_PKG_VERSION)-x86_64.AppImage

sed -e "s/@VERSION@/$ZRYTHM_VERSION/" \
  -e 's/@_AT_@/@/' < README$TRIAL.in > README
sed "s/@VERSION@/$ZRYTHM_VERSION/" \
  -e "s/@ZPLUGINS_VERSION@/$ZPLUGINS_VERSION/" \
  -e "s/@TRIAL@/$TRIAL/" \
  < installer.sh.in > installer.sh
chmod +x installer.sh

# TODO add *.AppImage
zip $INSTALLER_ZIP_FILE Zrythm-*.pdf installer.sh README \
  bin/**/*.* bin/**/**/* bin/**/**/**/* bin/**/**/**/**/*

rm -rf README installer.sh *.AppImage Zrythm-*.pdf
