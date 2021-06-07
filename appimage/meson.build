# Copyright (C) 2021 Alexandros Theodotou <alex at zrythm dot org>
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

appimage_conf = configuration_data ()
appimage_conf.merge_from (global_conf)
appimage_conf.set (
  'BUILT_ZPLUGINS_DIR', zplugins_installation.full_path ())
appimage_conf.set (
  'CARLA_DESTDIR', carla_installation.full_path ())
appimage_conf.set (
  'CARLA_PKG_CONFIG_PATH', carla_pkgconfig_path)
appimage_conf.set (
  'CARLA_FULL_BINS_PATH',
  carla_installation.full_path () + carla_prefix / 'carla')
appimage_conf.set (
  'APPDIR_PATH', '/tmp/AppDir')

find_program ('appimage-builder')

make_appimage_pkg = configure_file (
  output: 'make_appimage.sh',
  input: 'make_appimage.sh.in',
  configuration: appimage_conf,
  )

appimage_builder_yml = configure_file (
  output: 'appimage-builder.yml',
  input: 'appimage-builder.yml.in',
  configuration: appimage_conf,
  )

appimage_pkg_filename = run_command (
  get_pkg_filename, 'APPIMAGE', dash_trial).stdout ().strip ()
appimage_pkg = custom_target (
  'appimage-pkg',
  output: appimage_pkg_filename,
  input: [
    appimage_builder_yml, zrythm_src_tarball,
    ],
  command: [
    make_appimage_pkg, '@OUTPUT@', '@INPUT0@', '@INPUT1@',
    '@PRIVATE_DIR@',
    ],
  depends: [
    carla_installation,
    lsp_dsp_lib_installation,
    zplugins_installation,
    ],
  console: true,
  install: true,
  install_dir: get_option ('prefix'),
  )

run_target (
  'appimage',
  command: [ 'echo', 'done' ],
  depends: appimage_pkg)
