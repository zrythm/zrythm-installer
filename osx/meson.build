# Copyright (C) 2023 Alexandros Theodotou <alex at zrythm dot org>
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

osx_conf = configuration_data ()
osx_conf.merge_from (global_conf)
osx_conf.set (
  'DASH_TRIAL', dash_trial)
osx_conf.set (
  'TRIAL_INITIAL_UPPERCASE', build_trial ? 'Trial' : '')
osx_conf.set (
  'ZRYTHM_BOTTLE_FILENAME', zrythm_bottle_filename)
osx_conf.set (
  'CARLA_BOTTLE_VER', carla_bottle_ver)
osx_conf.set (
  'CARLA_BOTTLE_FILENAME', carla_bottle_filename)
installer_zip_filename = 'zrythm' + dash_trial + '-' + zrythm_pkg_ver + '-osx-installer.zip'
installer_pkg_filename = 'zrythm' + dash_trial + '-' + zrythm_pkg_ver + '-osx-installer.pkg'
osx_conf.set (
  'OSX_INSTALLER_ZIP_FILENAME', installer_zip_filename)
osx_conf.set (
  'OSX_INSTALLER_PKG_FILENAME', installer_pkg_filename)
osx_conf.set (
  'BREEZE_DARK', breeze_icons.full_path ())
zrythm_product_ver = zrythm_pkg_ver
if zrythm_product_ver.contains('-')
  zrythm_product_ver = zrythm_product_ver.split('-')[0]
endif
osx_conf.set (
  'ZRYTHM_PRODUCT_VERSION', zrythm_product_ver)
osx_conf.set (
  'BUILT_ZPLUGINS_DIR',
  zplugins_installation.full_path ())
osx_conf.set ('IS_TAG', is_tag ? 'true' : 'false')
osx_conf.set (
  'DEPS_PREFIX', get_option ('osx-deps-prefix'))

make_zrythm_deps = configure_file (
  output: 'make-zrythm-deps.sh',
  input: 'make-zrythm-deps.sh.in',
  configuration: osx_conf,
  )

zrythm_deps = custom_target (
  'zrythm-deps-target',
  output: 'zrythm-deps-finished',
  command: [
    make_zrythm_deps, '@OUTPUT@', '@PRIVATE_DIR@', meson_bin,
    ],
  console: true,
  )
