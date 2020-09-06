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

osx_brew_conf = configuration_data ()
osx_brew_conf.merge_from (global_conf)
carla_bottle_ver = '0.1.2'
carla_bottle_filename = 'carla-git--' + carla_bottle_ver + '.catalina.bottle.tar.gz'
zrythm_bottle_filename = 'zrythm' + dash_trial + '--' + zrythm_pkg_ver + '.catalina.bottle.tar.gz'
osx_brew_conf.set (
  'ZRYTHM_BOTTLE_FILENAME', zrythm_bottle_filename)
osx_brew_conf.set (
  'CARLA_BOTTLE_VER', carla_bottle_ver)
osx_brew_conf.set (
  'CARLA_BOTTLE_FILENAME', carla_bottle_filename)
carla_brew_src_sum = run_command (
  bash, '-c', 'openssl sha256 -r ' +
  carla_src_zip.full_path () +
  ' | awk \'{print $1;}\'').stdout (). strip ()
osx_brew_conf.set (
  'CARLA_BREW_SHA256', carla_brew_src_sum)
zrythm_brew_src_sum = run_command (
  bash, '-c', 'openssl sha256 -r ' +
  orig_zrythm_src_tarball.full_path () +
  ' | awk \'{print $1;}\'').stdout (). strip ()
osx_brew_conf.set (
  'ZRYTHM_BREW_SHA256', zrythm_brew_src_sum)
installer_zip_filename = 'zrythm' + dash_trial + '-' + zrythm_pkg_ver + '-osx-installer.zip'
osx_brew_conf.set (
  'OSX_INSTALLER_ZIP_FILENAME', installer_zip_filename)

make_breeze_icons = custom_target (
  'osx-breeze-icons',
  output: 'breeze-dark',
  input: breeze_dark_path,
  command: [
    'rm', '-rf', '@OUTPUT@', '&&',
    'cp', '-R', '@INPUT@', '@OUTPUT@', '&&',
    'cp', '-R', '@INPUT@', '/tmp/breeze-dark',
    ],
  install: false,
  )

# configure scripts
make_bottle_sh = configure_file (
  output: 'make_bottle.sh',
  input: 'make_bottle.sh.in',
  configuration: osx_brew_conf,
  )
make_zip_sh = configure_file (
  output: 'make_zip.sh',
  input: 'make_zip.sh.in',
  configuration: osx_brew_conf,
  )

# configure installer script and README
installer_sh = configure_file (
  output: 'installer.sh',
  input: 'installer.sh.in',
  configuration: osx_brew_conf,
  )
readme = configure_file (
  output: 'README',
  input: 'README-osx.in',
  configuration: osx_brew_conf,
  )

# prepare formulas
carla_formula = configure_file (
  output: 'carla-git.rb',
  input: 'carla-git.rb.in',
  configuration: osx_brew_conf,
  )
zrythm_formula = configure_file (
  output: 'zrythm' + dash_trial + '.rb',
  input: 'zrythm.rb.in',
  configuration: osx_brew_conf,
  )

carla_bottle = custom_target (
  'osx-carla-bottle',
  output: carla_bottle_filename,
  input: [
    make_bottle_sh, carla_formula,
    carla_src_zip,
    ],
  command: [
    make_bottle_sh, '@OUTPUT@',
    '@INPUT1@', '@PRIVATE_DIR@',
    '@INPUT2@',
    ],
  install: false,
  )
zrythm_bottle = custom_target (
  'osx-zrythm-bottle',
  output: zrythm_bottle_filename,
  input: [
    make_bottle_sh, zrythm_formula,
    carla_bottle, orig_zrythm_src_tarball,
    ],
  command: [
    make_bottle_sh, '@OUTPUT@',
    '@INPUT1@', '@PRIVATE_DIR@',
    '@INPUT3@',
    ],
  depends: make_breeze_icons, zplugins_installation,
  install: false,
  )

installer_zip = custom_target (
  'osx-installer-zip',
  output: installer_zip_filename,
  input: [
    make_zip_sh, zrythm_formula,
    carla_bottle, installer_sh,
    readme, zrythm_bottle,
    ],
  command: [
    make_zip_sh, '@OUTPUT@',
    '@INPUT1@', '@INPUT2@', '@INPUT3@', '@INPUT4@',
    '@PRIVATE_DIR@',
    ],
  install: true,
  install_dir: get_option ('prefix'),
  )

run_target (
  'osx-brew',
  command: [ 'echo', 'done' ],
  depends: installer_zip)
