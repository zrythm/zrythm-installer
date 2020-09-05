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
  'zrythm-installer', [ 'c' ],
  version: '0.1',
  meson_version: '>=0.55.0',
  license: 'AGPL-3-or-later',
  )

cc = meson.get_compiler ('c')

bash = find_program ('bash')
wget = find_program ('wget')
meson_bin = get_option ('meson-path')

prefix = get_option ('prefix')
libdir = get_option ('libdir')

distro = get_option ('distro')
zrythm_git_ver = get_option ('zrythm-git-ver')
zrythm_pkg_ver = get_option ('zrythm-pkg-ver')
zplugins_ver = get_option ('zplugins-ver')
carla_git_ver = get_option ('carla-git-ver')
lsp_dsp_lib_ver = get_option ('lsp-dsp-lib-ver')
build_trial = get_option ('build-trial')
orig_inner_dir_name = 'zrythm-' + zrythm_git_ver
orig_zrythm_src_tarball_filename = orig_inner_dir_name + '.tar.gz'
orig_zrythm_src_tarball_url = 'https://git.zrythm.org/cgit/zrythm/snapshot/' + orig_zrythm_src_tarball_filename
zrythm_inner_dir_name = 'zrythm-' + zrythm_pkg_ver
zrythm_src_tarball_filename = zrythm_inner_dir_name + '.tar.gz'
zplugins_src_tarball_filename = 'zplugins-' + zplugins_ver + '.tar.gz'
mingw_prefix = 'mingw-w64-x86_64-'
mingw_zrythm_pkg_filename = mingw_prefix + 'zrythm-' + zrythm_pkg_ver + '-1-any.pkg.tar.zst'
mingw_zrythm_trial_pkg_filename = mingw_prefix + 'zrythm-trial-' + zrythm_pkg_ver + '-1-any.pkg.tar.zst'
debian_src_tarball_filename = 'zrythm_' + zrythm_pkg_ver + '.orig.tar.gz'
temp_carla_prefix = meson.build_root () / 'tmp_carla_prefix'
temp_carla_pkgconfig_path = temp_carla_prefix / libdir / 'pkgconfig'
temp_zplugins_prefix = meson.build_root () / 'tmp_zplugins_prefix'
temp_zplugins_suffix = 'lib/lv2'
temp_zplugins_dir = temp_zplugins_prefix / temp_zplugins_suffix
temp_library_prefix = meson.build_root () / 'tmp_lib_prefix'
temp_library_pkgconfig_path = temp_library_prefix / libdir / 'pkgconfig'
dash_trial = build_trial ? '-trial' : ''
locales = get_option ('locales')
space_sep_locales = ''
foreach locale : locales
  space_sep_locales += locale + ' '
endforeach
space_sep_locales.strip ()
breeze_dark_path = get_option ('breeze-dark-path')
is_arch = distro.contains ('arch')
is_debian = distro.contains ('debian') or distro.contains ('ubuntu')
is_nixos = distro.contains ('nixos')
is_rpm = distro.contains ('fedora')
is_windows_msys = distro.contains ('windows10-msys')
is_osx_brew = distro.contains ('osx-brew')

global_conf = configuration_data ()
global_conf.set ('PREFIX', prefix)
global_conf.set (
  'MESON_BIN', meson_bin)
global_conf.set (
  'MESON_BUILD_ROOT', meson.build_root ())
global_conf.set (
  'MESON_SOURCE_ROOT', meson.source_root ())
global_conf.set (
  'BASH', bash.full_path ())
global_conf.set (
  'CC', cc.get_id ())
global_conf.set (
  'LIBDIR', libdir)
global_conf.set (
  'ZRYTHM_GIT_VERSION', zrythm_git_ver)
global_conf.set (
  'ZRYTHM_PKG_VERSION', zrythm_pkg_ver)
global_conf.set (
  'ZRYTHM_SOURCE_TARBALL_FILENAME',
  zrythm_src_tarball_filename)
global_conf.set (
  'ZRYTHM_INNER_DIR_NAME', zrythm_inner_dir_name)
global_conf.set (
  'ZRYTHM_ORIG_INNER_DIR_NAME', orig_inner_dir_name)
global_conf.set (
  'ZRYTHM_ORIG_SRC_TARBALL_FILENAME',
  orig_zrythm_src_tarball_filename)
global_conf.set (
  'ZRYTHM_ORIG_SRC_TARBALL_URL',
  orig_zrythm_src_tarball_url)
global_conf.set (
  'ZPLUGINS_VER', zplugins_ver)
global_conf.set (
  'CARLA_GIT_VER', carla_git_ver)
global_conf.set (
  'LSP_DSP_LIB_VER', lsp_dsp_lib_ver)
global_conf.set (
  'TEMP_LIBRARY_PREFIX', temp_library_prefix)
global_conf.set (
  'TEMP_LIBRARY_PKG_CONFIG_PATH', temp_library_pkgconfig_path)
global_conf.set (
  'TEMP_CARLA_PREFIX', temp_carla_prefix)
global_conf.set (
  'TEMP_CARLA_PKG_CONFIG_PATH', temp_carla_pkgconfig_path)
global_conf.set ('DASH_TRIAL', dash_trial)
global_conf.set (
  'TRIAL_TRUE_FALSE', build_trial ? 'true' : 'false')
global_conf.set (
  'SPACE_SEPARATED_LOCALES', space_sep_locales)
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
global_conf.set (
  'BREEZE_DARK_PATH', breeze_dark_path)
global_conf.set (
  'SUPPORTING_TEXT', build_trial ? 'supporting' : 'trying out')
global_conf.set ('EMAIL_AT_SYM', '@')

subdir ('scripts')
subdir ('sources')

carla_installation = custom_target (
  'carla-installation',
  output: 'carla-native-plugin.pc',
  input: carla_src_zip,
  command: [
    make_carla, '@INPUT@', carla_git_ver, '@PRIVATE_DIR@', '&&',
    'cp', temp_carla_pkgconfig_path / 'carla-native-plugin.pc',
    '@OUTPUT@',
    ],
  install: false,
  )

zplugins_installation = custom_target (
  'zplugins-installation',
  output: 'built_zplugins',
  input: zplugins_src_tarball,
  command: [
    'rm', '-rf', '@OUTPUT@', '&&',
    make_zplugins, zplugins_src_tarball,
    temp_zplugins_prefix, temp_zplugins_suffix,
    '@PRIVATE_DIR@', '&&',
    'mv', temp_zplugins_prefix / temp_zplugins_suffix,
    '@OUTPUT@'
    ],
  install: false,
  )

lsp_dsp_lib_installation = custom_target (
  'lsp-dsp-lib-installation',
  output: 'lsp-dsp-lib.pc',
  input: lsp_dsp_lib_src_tarball,
  command: [
    make_lsp_dsp_lib, '@INPUT@', '&&',
    'cp', temp_library_pkgconfig_path / 'lsp-dsp-lib.pc',
    '@OUTPUT@',
    ],
  install: false,
  )

if is_arch
subdir ('arch')
endif

if is_debian
subdir ('debian')
endif

if is_nixos
subdir ('nixos')
endif

if is_rpm
subdir ('rpm')
endif

if is_windows_msys
subdir ('windows-msys')
endif

if is_osx_brew
subdir ('osx-brew')
endif
