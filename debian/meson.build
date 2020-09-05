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

debian_changelog = configure_file (
  output: 'changelog.in',
  input: 'changelog',
  configuration: global_conf,
  )

debian_control = configure_file (
  output: 'control.in',
  input: 'control',
  configuration: global_conf,
  )

debian_rules = configure_file (
  output: 'rules.in',
  input: 'rules',
  configuration: global_conf,
  )

debian_pkg_filename = run_command (
  get_pkg_filename, 'DEBIAN').stdout ().strip ()
debian_pkg = custom_target (
  'debian-pkg',
  output: debian_pkg_filename,
  input: [
    debian_changelog, debian_rules,
    'compat', debian_control, 'copyright',
    ],
  command: [
    make_debian_pkg, '@OUTPUT@', '@INPUT0@', '@INPUT1@',
    '@INPUT2@', '@INPUT3@', '@INPUT4@',
    ],
  depends: [
    debian_zrythm_src_tarball_gzipped,
    carla_installation,
    lsp_dsp_lib_installation,
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
