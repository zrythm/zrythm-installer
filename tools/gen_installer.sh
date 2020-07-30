#! /bin/bash

set -e

# args:
# 1: zrythm version
# 2: installer zip filename
# 3: zplugins version
# 4: `-trial` if trial, otherwise empty

zrythm_version=$1
installer_zip=$2
zplugins_version=$3
trial=$4
distros="archlinux debian10 debian11 ubuntu1804 ubuntu2004 ubuntu2010 fedora31 fedora32"

rm -rf $installer_zip

sed -i -e "s/ZRYTHM_PKG_VERSION=.*/ZRYTHM_PKG_VERSION=$zrythm_version/" Makefile

is_trial () {
  [ "$trial" = "-trial" ]
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
  if ! is_trial ; then
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
    "debian"* | "ubuntu"*)
      search_str="DEBIAN"
      ;;
    "archlinux")
      search_str="ARCH"
      ;;
    "fedora"*)
      search_str="FEDORA"
      ;;
  esac
  if is_trial ; then
    echo "$(make --no-print-directory -s pkg-trial-filename-$search_str)"
  else
    echo "$(make --no-print-directory -s pkg-filename-$search_str)"
  fi
}

# returns the filename to be placed inside "bin"
get_dest_package_filename () {
  prefix="zrythm-$zrythm_version"
  distro=$1
  res=""
  case "$distro" in
    "debian10" | "ubuntu"*)
      res="$prefix-1_amd64.deb"
      ;;
    "archlinux")
      res="$prefix-1_x86_64.pkg.tar.zst"
      ;;
    "fedora"*)
      res="$prefix-1_x86_64.rpm"
  esac
  echo $res
}

copy_package () {
  distro=$1
  src_pkg_file="$(get_package_filename $distro)"
  dest_pkg_file="$(get_dest_package_filename $distro)"
  cp "artifacts/$distro/$src_pkg_file" "bin/$distro/$dest_pkg_file"
}

echo "removing previous backup (if any)"
# remove prev backup
rm -rf bin.bak
mv bin bin.bak || true

for distro in $distros ; do
  mkdir -p bin/$distro
  echo "copying plugins for $distro..."
  copy_plugins $distro
  echo "done"
  echo "copying packages for $distro..."
  copy_package $distro
  echo "done"
done

#cp artifacts/debian9/Zrythm$(2)-$(ZRYTHM_PKG_VERSION)-x86_64.AppImage \
  #Zrythm$(2)-$(ZRYTHM_PKG_VERSION)-x86_64.AppImage

sed -e "s/@VERSION@/$zrythm_version/" \
  -e 's/@_AT_@/@/' < README$trial.in > README
sed -e "s/@VERSION@/$zrythm_version/" \
  -e "s/@ZPLUGINS_VERSION@/$zplugins_version/" \
  -e "s/@TRIAL@/$trial/" \
  < installer.sh.in > installer.sh
chmod +x installer.sh

pdf=""
if ! is_trial ; then
  pdf="$(ls Zrythm-*.pdf)"
fi

echo "zipping installer..."
installer_zip_dir=${installer_zip::-4}
mkdir $installer_zip_dir
cp -R $pdf installer.sh README bin $installer_zip_dir/
zip -r $installer_zip $installer_zip_dir
echo "done"

echo "cleaning up..."
#rm -rf README installer.sh *.AppImage $pdf
rm -rf README installer.sh *.AppImage $installer_zip_dir
echo "done"
