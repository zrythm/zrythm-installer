# Copyright (C) 2020-2022 Alexandros Theodotou <alex at zrythm dot org>
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

gnu_linux_conf = configuration_data ()
gnu_linux_conf.merge_from (global_conf)
gnu_linux_conf.set (
  'DEPS_PREFIX', get_option ('gnu-linux-deps-prefix'))

make_zrythm = configure_file (
  output: 'make-zrythm.sh',
  input: 'make-zrythm.sh.in',
  configuration: gnu_linux_conf,
  )

make_zrythm_deps = configure_file (
  output: 'make-zrythm-deps.sh',
  input: 'make-zrythm-deps.sh.in',
  configuration: gnu_linux_conf,
  )

# configure scripts
make_installer_zip_sh = configure_file (
  output: 'make_installer_zip.sh',
  input: 'make_installer_zip.sh.in',
  configuration: gnu_linux_conf,
  )

# configure installer script and README
installer_sh = configure_file (
  output: 'install.sh',
  input: 'install.sh.in',
  configuration: gnu_linux_conf,
  )
readme = configure_file (
  output: 'README',
  input: 'README.in',
  configuration: gnu_linux_conf,
  )

zrythm_deps = custom_target (
  'zrythm-deps-target',
  output: 'zrythm-deps-finished',
  command: [
    make_zrythm_deps, '@OUTPUT@', '@PRIVATE_DIR@', meson_bin,
    ],
  console: true,
  )

# this target installs zrythm with prefix = /opt/... and DESTDIR in meson's
# private dir
# it will be copied in the installer zip
zrythm_installed_target = custom_target (
  'zrythm-installed-target',
  output: 'zrythm-installed',
  input: [
    zrythm_src_tarball ],
  command: [
    make_zrythm, '@OUTPUT@', '@PRIVATE_DIR@', '@INPUT0@',
    '/opt/zrythm' + dash_trial + '-' + zrythm_pkg_ver,
    meson_bin, zplugins_src_tarball,
    ],
  depends: zrythm_deps,
  console: true,
  )

installer_zip_filename = run_command (
  get_pkg_filename_from_distro, get_option ('distro'), dash_trial).stdout ().strip ()
installer_zip = custom_target (
  'gnu-linux-installer-zip',
  output: installer_zip_filename,
  input: [
    make_installer_zip_sh, installer_sh, readme,
    zrythm_installed_target,
    ],
  command: [
    make_installer_zip_sh, '@OUTPUT@', '@PRIVATE_DIR@',
    '@INPUT1@', '@INPUT2@', '@INPUT3@',
    ],
  install: true,
  install_dir: get_option ('prefix'),
  console: true,
  )

run_target (
  'gnu-linux-zrythm-deps',
  command: [ 'echo', 'done' ],
  depends: zrythm_deps)
run_target (
  'gnu-linux-packages',
  command: [ 'echo', 'done' ],
  depends: installer_zip)
