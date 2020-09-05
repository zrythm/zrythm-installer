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

scripts_conf = configuration_data ()
scripts_conf.merge_from (global_conf)
scripts_conf.set ('SCRIPTS_DIR', meson.current_build_dir ())
scripts_conf.set ('BASH', bash.full_path ())

# configure each script
make_windows_chroot = configure_file (
  output: 'make_windows_chroot.sh',
  input: 'make_windows_chroot.sh.in',
  configuration: scripts_conf,
  )

make_debian_pkg = configure_file (
  output: 'make_debian_pkg.sh',
  input: 'make_debian_pkg.sh.in',
  configuration: scripts_conf,
  )

make_rpm_pkg = configure_file (
  output: 'make_rpm_pkg.sh',
  input: 'make_rpm_pkg.sh.in',
  configuration: scripts_conf,
  )

make_arch_pkg = configure_file (
  output: 'make_arch_pkg.sh',
  input: 'make_arch_pkg.sh.in',
  configuration: scripts_conf,
  )

make_nixos_pkg = configure_file (
  output: 'make_nixos_pkg.sh',
  input: 'make_nixos_pkg.sh.in',
  configuration: scripts_conf,
  )

make_user_manual = configure_file (
  output: 'make_user_manual.sh',
  input: 'make_user_manual.sh.in',
  configuration: scripts_conf,
  )

make_carla = configure_file (
  output: 'make_carla.sh',
  input: 'make_carla.sh.in',
  configuration: scripts_conf,
  )

make_lsp_dsp_lib = configure_file (
  output: 'make_lsp_dsp_lib.sh',
  input: 'make_lsp_dsp_lib.sh.in',
  configuration: scripts_conf,
  )

get_pkg_filename = configure_file (
  output: 'get_pkg_filename.sh',
  input: 'get_pkg_filename.sh.in',
  configuration: scripts_conf,
  )

make_zplugins = configure_file (
  output: 'make_zplugins.sh',
  input: 'make_zplugins.sh.in',
  configuration: scripts_conf,
  )

built_scripts_dir = meson.current_build_dir ()
