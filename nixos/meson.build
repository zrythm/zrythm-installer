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

nixos_conf = configuration_data ()
nixos_conf.merge_from (global_conf)
nixos_conf.set (
  'BUILT_ZPLUGINS_DIR', zplugins_installation.full_path ())

pkgbuild = configure_file (
  output: 'PKGBUILD',
  input: 'PKGBUILD.in',
  configuration: nixos_conf,
  )

nixos_pkg_filename = run_command (
  get_pkg_filename, 'ARCH', dash_trial).stdout ().strip ()
nixos_pkg = custom_target (
  'nixos-pkg',
  output: nixos_pkg_filename,
  input: [
    pkgbuild, zrythm_src_tarball,
    ],
  command: [
    make_nixos_pkg, '@OUTPUT@', '@INPUT0@', '@INPUT1@',
    zrythm_src_tarball_filename, nixos_pkg_filename,
    ],
  depends: [
    carla_installation,
    lsp_dsp_lib_installation,
    zplugins_installation,
    ],
  install: true,
  install_dir: get_option ('prefix'),
  )

run_target (
  'nixos',
  command: [ 'echo', 'done' ],
  depends: nixos_pkg)
