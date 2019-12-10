#!/bin/sh

zrythm_ver="0.7.093"
architecture="amd64"

distro_ver=0
os_release_file="/etc/os-release"

# ---- Detect debian based systems ----
is_ubuntu=0
is_debian=0
# LTS is version x.04
ubuntu_lts="04"

debian_10_str="Debian GNU/Linux 10"
ubuntu_19_04_str="Ubuntu 19.04"
ubuntu_19_10_str="Ubuntu 19.10"
lsb_release_cmd=lsb_release

if ! type "$lsb_release_cmd" > /dev/null; then
  echo "found lsb_release"
  if $(lsb_release -a | grep -q "$ubuntu_19_04_str"); then
    echo "found $ubuntu_19_04_str"
    is_ubuntu=1
    distro_ver=19
    ubuntu_lts="04"
  elif $(lsb_release -a | grep -q "$ubuntu_19_10_str"); then
    echo "found $ubuntu_19_10_str"
    is_ubuntu=1
    distro_ver=19
    ubuntu_lts="10"
  elif $(lsb_release -a | grep -q "$debian_10_str"); then
    echo "found $debian_10_str"
    is_debian=1
    distro_ver=10
  fi
fi

# ---- Detect arch systems ----

arch_str="Arch GNU/Linux"
is_arch=0

if [ -e "$os_release_file" ]; then
  if $(cat "$os_release_file" | grep -q "Arch"); then
    echo "found $arch_str"
    architecture="x86_64"
    is_arch=1
  fi
fi

# ---- Detect fedora ----

is_fedora=0
fedora_30_str="Fedora 30"
fedora_31_str="Fedora 31"

if [ -e "$os_release_file" ]; then
  if $(cat "$os_release_file" | grep -q "Fedora"); then
    is_fedora=1
    architecture="x86_64"
    if $(cat "$os_release_file" | grep -q "VERSION_ID=31"); then
      echo "found $fedora_31_str"
      distro_ver=31
    elif $(cat "$os_release_file" | grep -q "VERSION_ID=30"); then
      echo "found $fedora_30_str"
      distro_ver=30
    fi
  fi
fi

# ---- Install ----

if [ $is_ubuntu == 0 -a $is_debian == 0 -a \
  $is_arch == 0 -a $is_fedora == 0 ]; then
  zenity --error --text="Could not detect your distro. \
Please contact the Zrythm developers for assistance."
  exit 1
fi

ask_for_root_pw_text="Please enter your root password in the terminal to continue"
if zenity --question --text="Proceed with the installation of Zrythm?"; then
  if [ $is_ubuntu == 1 ]; then
    zenity --info --text="$ask_for_root_pw_text"
    sudo /bin/sh -c "dpkg -i \"bin/ubuntu/zrythm-${zrythm_ver}-1_${distro_ver}.${ubuntu_lts}_${architecture}.deb\""
  elif [ $is_debian == 1 ]; then
    zenity --info --text="$ask_for_root_pw_text"
    sudo /bin/sh -c "dpkg -i \"bin/debian/zrythm-${zrythm_ver}-1_${distro_ver}_${architecture}.deb\""
  elif [ $is_fedora == 1 ]; then
    zenity --info --text="$ask_for_root_pw_text"
    sudo /bin/sh -c "dnf -y install \"bin/fedora/zrythm-${zrythm_ver}-3_${distro_ver}_${architecture}.rpm\""
  fi
else
  exit 0
fi
