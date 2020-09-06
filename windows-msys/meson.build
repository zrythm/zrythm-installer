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

# install dependencies
make_mingw_pkg_full_path = meson.build_root () / 'scripts/make_mingw_pkg.sh'
independent_dep_names = [ 'jack2', 'lsp-dsp-lib', ]
independent_deps = []
foreach dep_name : independent_dep_names
  src_pkgbuild = 'PKGBUILD-' + dep_name + '-mingw'
  independent_deps += custom_target (
    'mingw-' + dep_name,
    output: dep_name + '.pkg.tar.zst',
    input: [ make_mingw_pkg, src_pkgbuild, ],
    command: [
      # does not work with @INPUT0@ and @INPUT1@
      bash, '-c', make_mingw_pkg_full_path +
      ' @OUTPUT@ ' +
      meson.current_source_dir () / src_pkgbuild,
      ],
    install: false,
    )
endforeach
src_pkgbuild = 'PKGBUILD-lv2-mingw'
lv2_pkg = custom_target (
  'mingw-lv2',
  output: 'lv2.pkg.tar.zst',
  input: [ src_pkgbuild, make_mingw_pkg, ],
  command: [
    bash, '-c', make_mingw_pkg_full_path +
    ' @OUTPUT@ ' +
    meson.current_source_dir () / src_pkgbuild,
    ],
  install: false,
  )
src_pkgbuild = 'PKGBUILD-serd-mingw'
serd_pkg = custom_target (
  'mingw-serd',
  output: 'serd.pkg.tar.zst',
  input: [ src_pkgbuild, make_mingw_pkg, ],
  command: [
    bash, '-c', make_mingw_pkg_full_path +
    ' @OUTPUT@ ' +
    meson.current_source_dir () / src_pkgbuild,
    ],
  install: false,
  )
src_pkgbuild = 'PKGBUILD-sord-mingw'
sord_pkg = custom_target (
  'mingw-sord',
  output: 'sord.pkg.tar.zst',
  input: [ src_pkgbuild, make_mingw_pkg, ],
  command: [
    bash, '-c', make_mingw_pkg_full_path +
    ' @OUTPUT@ ' +
    meson.current_source_dir () / src_pkgbuild,
    ],
  install: false,
  )
src_pkgbuild = 'PKGBUILD-sratom-mingw'
sratom_pkg = custom_target (
  'mingw-sratom',
  output: 'sratom.pkg.tar.zst',
  input: [ src_pkgbuild, make_mingw_pkg, ],
  command: [
    bash, '-c', make_mingw_pkg_full_path +
    ' @OUTPUT@ ' +
    meson.current_source_dir () / src_pkgbuild,
    ],
  install: false,
  )
src_pkgbuild = 'PKGBUILD-lilv-mingw'
lilv_pkg = custom_target (
  'mingw-lilv',
  output: 'lilv.pkg.tar.zst',
  input: [ src_pkgbuild, make_mingw_pkg, ],
  command: [
    bash, '-c', make_mingw_pkg_full_path +
    ' @OUTPUT@ ' +
    meson.current_source_dir () / src_pkgbuild,
    ],
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
    carla_woe32_binary_64_zip, carla_woe32_binary_32_zip,
    ],
  command: [
    bash, '-c', 'unzip -o ' +
    carla_woe32_binary_64_zip.full_path () +
    ' -d /mingw64/ && unzip -o ' +
    carla_woe32_binary_32_zip.full_path () +
    ' -d /mingw64/lib/carla' +
    ' && touch @OUTPUT@'
    ],
  install: false,
  )

output_file = 'zrythm' + dash_trial + '.pkg.tar.zst'
mingw_zrythm_pkgbuild_full_path = meson.current_build_dir () / 'PKGBUILD'
mingw_zrythm_pkg = custom_target (
  'mingw-zrythm-pkg',
  output: output_file,
  input: [
    mingw_zrythm_pkgbuild, zrythm_src_tarball,
    zplugins_src_tarball,
    ],
  command: [
    bash, '-c',
    meson.build_root () / 'scripts/make_zrythm_mingw_pkg.sh ' +
    meson.current_build_dir () / output_file + ' ' +
    mingw_zrythm_pkgbuild_full_path + ' ' +
    zrythm_src_tarball.full_path () + ' ' +
    zplugins_src_tarball.full_path () + ' ' +
    '@PRIVATE_DIR@'
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
    zrythm_src_tarball, independent_deps[0],
    independent_deps[1], lv2_pkg, serd_pkg, sord_pkg,
    sratom_pkg, lilv_pkg, mingw_zrythm_pkg,
    make_windows_chroot,
    ],
  command: [
    bash, '-c',
    meson.build_root () / 'scripts/make_windows_chroot.sh ' +
    chroot_dir + ' ' +
    zrythm_src_tarball.full_path () + ' ' +
    independent_deps[0].full_path () + ' ' +
    independent_deps[1].full_path () + ' ' +
    lv2_pkg.full_path () + ' ' +
    serd_pkg.full_path () + ' ' +
    sord_pkg.full_path () + ' ' +
    sratom_pkg.full_path () + ' ' +
    lilv_pkg.full_path () + ' ' +
    mingw_zrythm_pkg.full_path () +
    ' && touch @OUTPUT@'
    ],
  depends: [
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
    meson.build_root () / 'scripts/make_windows_installer.sh' +
    ' @OUTPUT@ ' + zrythm_src_tarball.full_path () + ' ' +
    chroot_dir + ' ' +
    meson.current_source_dir () / 'installer.iss' +
    ' @PRIVATE_DIR@ ' +
    meson.current_source_dir () / 'copy-dll-deps.sh' + ' ' +
    rcedit_x64_exe.full_path ()
    ],
  depends: [
    windows_chroot_target,
    ],
  install: true,
  install_dir: get_option ('prefix'),
  )
