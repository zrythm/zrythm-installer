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

gnu_linux_zip_conf = configuration_data ()
gnu_linux_zip_conf.merge_from (global_conf)

# configure scripts
make_installer_zip_sh = configure_file (
  output: 'make_installer_zip.sh',
  input: 'make_installer_zip.sh.in',
  configuration: gnu_linux_zip_conf,
  )

# configure installer script and README
installer_sh = configure_file (
  output: 'installer.sh',
  input: 'installer.sh.in',
  configuration: gnu_linux_zip_conf,
  )
readme = configure_file (
  output: 'README',
  input: 'README.in',
  configuration: gnu_linux_zip_conf,
  )

installer_zip_filename = run_command (
  get_pkg_filename_from_distro, get_option ('distro')).stdout ().strip ()
installer_zip = custom_target (
  'gnu-linux-installer-zip',
  output: installer_zip_filename,
  input: [
    make_installer_zip_sh, installer_sh, readme,
    ],
  command: [
    make_installer_zip_sh, '@OUTPUT@', '@PRIVATE_DIR@',
    '@INPUT1@', '@INPUT2@',
    ],
  install: true,
  install_dir: get_option ('prefix'),
  )

run_target (
  'gnu-linux',
  command: [ 'echo', 'done' ],
  depends: installer_zip)
