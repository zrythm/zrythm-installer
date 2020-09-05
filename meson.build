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

project (
  'zrythm-installer',
  version: '0.1',
  meson_version: '>=0.55.0',
  license: 'AGPL-3-or-later',
  )

bash = find_program ('bash')
meson_bin = find_program ('meson')

prefix = get_option ('prefix')
libdir = get_option ('libdir')

zrythm_git_ver = get_option ('zrythm-git-ver')
zrythm_pkg_ver = get_option ('zrythm-pkg-ver')
zplugins_ver = get_option ('zplugins-ver')
carla_git_ver = get_option ('carla-git-ver')
build_trial = get_option ('build-trial')
zrythm_src_tarball_filename = 'zrythm-' + zrythm_pkg_ver + '.tar.gz'
zplugins_src_tarball_filename = 'zplugins-' + zplugins_ver + '.tar.gz'
mingw_prefix = 'mingw-w64-x86_64-'
mingw_zrythm_pkg_filename = mingw_prefix + 'zrythm-' + zrythm_pkg_ver + '-1-any.pkg.tar.zst'
mingw_zrythm_trial_pkg_filename = mingw_prefix + 'zrythm-trial-' + zrythm_pkg_ver + '-1-any.pkg.tar.zst'
debian_src_tarball_filename = 'zrythm_' + zrythm_pkg_ver + '.orig.tar.gz'
temp_lib_zrythm_dir = meson.build_root () / 'tmp' / libdir / 'zrythm'
temp_zplugins_prefix = meson.build_root () / 'tmp_zplugins_prefix'
temp_zplugins_suffix = 'lib/lv2'
temp_zplugins_dir = temp_zplugins_prefix / temp_zplugins_suffix
temp_library_prefix = meson.build_root () / 'tmp_lib_prefix'
temp_library_pkgconfig_path = temp_library_prefix / libdir / 'pkgconfig'

global_conf = configuration_data ()
global_conf.set ('PREFIX', prefix)
global_conf.set (
  'MESON_BIN', meson_bin.full_path ())
global_conf.set (
  'MESON_BUILD_ROOT', meson.build_root ())
global_conf.set (
  'MESON_SOURCE_ROOT', meson.source_root ())
global_conf.set (
  'ZRYTHM_GIT_VERSION', zrythm_git_ver)
global_conf.set (
  'ZRYTHM_PKG_VERSION', zrythm_pkg_ver)
global_conf.set (
  'ZPLUGINS_VER', zplugins_ver)
global_conf.set (
  'DASH_TRIAL', build_trial ? '-trial' : '')
global_conf.set (
  'MINGW_ZRYTHM_PKG_FILENAME', mingw_zrythm_pkg_filename)
global_conf.set (
  'MINGW_ZRYTHM_TRIAL_PKG_FILENAME', mingw_zrythm_trial_pkg_filename)
global_conf.set (
  'LV2_VERSION', get_option ('lv2-ver'))
global_conf.set (
  'SERD_VERSION', get_option ('serd-ver'))
global_conf.set (
  'SORD_VERSION', get_option ('sord-ver'))
global_conf.set (
  'SRATOM_VERSION', get_option ('sratom-ver'))
global_conf.set (
  'LILV_VERSION', get_option ('lilv-ver'))
global_conf.set (
  'JACK_VERSION', get_option ('jack-ver'))

subdir ('scripts')
subdir ('sources')

carla_installation = custom_target (
  'carla-installation',
  output: 'carla-native-plugin.pc',
  input: carla_src_zip,
  command: [
    make_carla, temp_lib_zrythm_dir, 'sudo', '@INPUT@', carla_git_ver, '&&',
    'cp', temp_lib_zrythm_dir + '/lib/pkgconfig/carla-native-plugin.pc', '@OUTPUT@',
    ],
  install: false,
  )

# this is the parent dir
zplugins_installation = custom_target (
  'zplugins-installation',
  output: 'built_zplugins',
  input: zplugins_src_tarball,
  command: [
    make_zplugins, zplugins_src_tarball,
    temp_zplugins_prefix, temp_zplugins_suffix, '&&',
    'mv', temp_zplugins_prefix / temp_zplugins_suffix,
    '@OUTPUT@'
    ],
  install: false,
  )

debian_pkg_filename = run_command (
  get_pkg_filename, 'DEBIAN').stdout ().strip ()
debian_pkg = custom_target (
  'debian-pkg',
  output: debian_pkg_filename,
  command: [
    make_debian_pkg, '-o', '@OUTPUT@',
    ],
  depends: [
    debian_zrythm_src_tarball_gzipped,
    #carla_installation,
    zrythm_src_tarball,
    zplugins_installation,
    ],
  install: true,
  install_dir: get_option ('prefix'),
  )

run_target (
  'debian',
  command: [ 'echo', 'done' ],
  depends: debian_pkg)
