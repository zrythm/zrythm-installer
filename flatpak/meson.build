# Copyright (C) 2022 Alexandros Theodotou <alex at zrythm dot org>
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

flatpak_conf = configuration_data ()
flatpak_conf.merge_from (global_conf)
#flatpak_conf.set (
  #'BUILT_ZPLUGINS_DIR', zplugins_installation.full_path ())

find_program ('flatpak')
find_program ('flatpak-builder')

make_flatpak_pkg = configure_file (
  output: 'make_flatpak.sh',
  input: 'make_flatpak.sh.in',
  configuration: flatpak_conf,
  )

flatpak_json = configure_file (
  output: 'org.zrythm.Zrythm.json',
  input: 'org.zrythm.Zrythm.json',
  configuration: flatpak_conf,
  )

flatpak_pkg_filename = run_command (
  get_pkg_filename, 'FLATPAK', dash_trial).stdout ().strip ()
flatpak_pkg = custom_target (
  'flatpak-pkg',
  output: flatpak_pkg_filename,
  input: [ flatpak_json, ],
  command: [
    make_flatpak_pkg, '@OUTPUT@', '@INPUT0@',
    '@PRIVATE_DIR@',
    meson.current_source_dir () / 'shared-modules',
    ],
  console: true,
  install: true,
  install_dir: get_option ('prefix'),
  )

run_target (
  'flatpak',
  command: [ 'echo', 'done' ],
  depends: flatpak_pkg)
