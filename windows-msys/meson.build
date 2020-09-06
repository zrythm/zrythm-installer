# Copyright (C) 2020 Alexandros Theodotou <alex at zrythm dot org>
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

windows_msys_conf = configuration_data ()
windows_msys_conf.merge_from (global_conf)

mingw_zrythm_pkgbuild = configure_file (
  output: 'PKGBUILD',
  input: 'PKGBUILD-w10.in',
  configuration: windows_msys_conf,
  )

# configure scripts
make_windows_chroot = configure_file (
  output: 'make_windows_chroot.sh',
  input: 'make_windows_chroot.sh.in',
  configuration: global_conf,
  )
make_windows_installer = configure_file (
  output: 'make_windows_installer.sh',
  input: 'make_windows_installer.sh.in',
  configuration: global_conf,
  )
make_mingw_pkg = configure_file (
  output: 'make_mingw_pkg.sh',
  input: 'make_mingw_pkg.sh.in',
  configuration: global_conf,
  )
make_zrythm_mingw_pkg = configure_file (
  output: 'make_zrythm_mingw_pkg.sh',
  input: 'make_zrythm_mingw_pkg.sh.in',
  configuration: global_conf,
  )
install_carla = configure_file (
  output: 'install_carla.sh',
  input: 'install_carla.sh.in',
  configuration: global_conf,
  )

make_mingw_pkg_cmd = [
  bash, '-c', '@INPUT0@ "$1" "$2" "$3"', '_ignored',
  '@OUTPUT@', '@INPUT1@', '@PRIVATE_DIR@'
  ]

# install dependencies
independent_dep_names = [ 'jack2', 'lsp-dsp-lib', ]
independent_deps = []
foreach dep_name : independent_dep_names
  independent_deps += custom_target (
    'mingw-' + dep_name,
    output: dep_name + '.pkg.tar.zst',
    input: [
      make_mingw_pkg, 'PKGBUILD-' + dep_name + '-mingw',
      ],
    command: make_mingw_pkg_cmd,
    install: false,
    )
endforeach
lv2_pkg = custom_target (
  'mingw-lv2',
  output: 'lv2.pkg.tar.zst',
  input: [ make_mingw_pkg, 'PKGBUILD-lv2-mingw', ],
  command: make_mingw_pkg_cmd,
  install: false,
  )
serd_pkg = custom_target (
  'mingw-serd',
  output: 'serd.pkg.tar.zst',
  input: [ make_mingw_pkg, 'PKGBUILD-serd-mingw', ],
  command: make_mingw_pkg_cmd,
  depends: lv2_pkg,
  install: false,
  )
sord_pkg = custom_target (
  'mingw-sord',
  output: 'sord.pkg.tar.zst',
  input: [ make_mingw_pkg, 'PKGBUILD-sord-mingw', ],
  command: make_mingw_pkg_cmd,
  depends: serd_pkg,
  install: false,
  )
sratom_pkg = custom_target (
  'mingw-sratom',
  output: 'sratom.pkg.tar.zst',
  input: [ make_mingw_pkg, 'PKGBUILD-sratom-mingw', ],
  command: make_mingw_pkg_cmd,
  depends: sord_pkg,
  install: false,
  )
lilv_pkg = custom_target (
  'mingw-lilv',
  output: 'lilv.pkg.tar.zst',
  input: [ make_mingw_pkg, 'PKGBUILD-lilv-mingw', ],
  command: make_mingw_pkg_cmd,
  depends: sratom_pkg,
  install: false,
  )

# get carla binary zips
carla_bin_base_url = 'https://www.zrythm.org/downloads/carla/'
filename = 'carla-2.2.0-rc1-woe32.zip'
url = carla_bin_base_url + filename
carla_woe32_binary_32_zip = custom_target (
  'carla-woe32-binary-32-zip',
  output: filename,
  command: [
    'wget', url, '-O', '@OUTPUT@',
    ],
  install: false,
  )
carla_short_git_ver = run_command (
  'bash', '-c', 'echo ' + carla_git_ver + ' | head -c 7').stdout ().strip ()
filename = 'carla-64-' + carla_short_git_ver + '.zip'
url = carla_bin_base_url + filename
carla_woe32_binary_64_zip = custom_target (
  'carla-woe32-binary-64-zip',
  output: filename,
  command: [
    'wget', url, '-O', '@OUTPUT@',
    ],
  install: false,
  )

mingw_install_carla_bins_target = custom_target (
  'mingw-install-carla',
  output: 'carla-installed',
  input: [
    install_carla, carla_woe32_binary_64_zip,
    carla_woe32_binary_32_zip,
    ],
  command: [
    bash, '-c', '@INPUT0@ "$1" "$2" "$3"', '_ignored',
    '@OUTPUT@', '@INPUT1@', '@INPUT2@'
    ],
  install: false,
  )

mingw_zrythm_pkg = custom_target (
  'mingw-zrythm-pkg',
  output: 'zrythm' + dash_trial + '.pkg.tar.zst',
  input: [
    make_zrythm_mingw_pkg, mingw_zrythm_pkgbuild,
    zrythm_src_tarball, zplugins_src_tarball,
    ],
  command: [
    bash, '-c',
    '@INPUT0@ "$1" "$2" "$3" "$4" "$5"', '_ignored',
    '@OUTPUT@', '@INPUT1@', '@INPUT2@',
    '@INPUT3@', '@PRIVATE_DIR@',
    ],
  depends: [
    mingw_install_carla_bins_target, lilv_pkg,
    independent_deps,
    ],
  install: false,
  )

chroot_dir = '/tmp/zrythm' + dash_trial + '-chroot'
windows_chroot_target = custom_target (
  'windows-chroot',
  output: 'zrythm-test',
  input: [
    make_windows_chroot, zrythm_src_tarball,
    independent_deps[0],
    independent_deps[1], lv2_pkg, serd_pkg, sord_pkg,
    sratom_pkg, lilv_pkg, mingw_zrythm_pkg,
    ],
  command: [
    bash, '-c',
    '@INPUT0@ "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" ' +
    '"$9" "${10}" "${11}"',
    '_ignored',
    '@OUTPUT@', chroot_dir, '@INPUT1@', '@INPUT2@',
    '@INPUT3@', '@INPUT4@', '@INPUT5@', '@INPUT6@',
    '@INPUT7@', '@INPUT8@', '@INPUT9@',
    ],
  install: false,
  )

windows_msys_installer_filename = run_command (
  bash, '-c',
  meson.build_root () / 'scripts/get_pkg_filename.sh' +
  ' WINDOWS_MSYS ' + dash_trial).stdout ().strip ()
windows_msys_installer = custom_target (
  'windows-msys-installer',
  output: windows_msys_installer_filename,
  input: [
    make_windows_installer, zrythm_src_tarball,
    'installer.iss', 'copy-dll-deps.sh',
    rcedit_x64_exe,
    ],
  command: [
    bash, '-c',
    '@INPUT0@ "$1" "$2" "$3" "$4" "$5" "$6" "$7"',
    '_ignored',
    '@OUTPUT@', '@INPUT1@', chroot_dir, '@INPUT2@',
    '@PRIVATE_DIR@', '@INPUT3@', '@INPUT4@',
    ],
  depends: [
    windows_chroot_target,
    ],
  install: true,
  install_dir: get_option ('prefix'),
  )
