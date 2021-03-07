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

# configure each script

make_arch_pkg = configure_file (
  output: 'make_arch_pkg.sh',
  input: 'make_arch_pkg.sh.in',
  configuration: global_conf,
  )

make_nixos_pkg = configure_file (
  output: 'make_nixos_pkg.sh',
  input: 'make_nixos_pkg.sh.in',
  configuration: global_conf,
  )

make_user_manual = configure_file (
  output: 'make_user_manual.sh',
  input: 'make_user_manual.sh.in',
  configuration: global_conf,
  )

make_carla = configure_file (
  output: 'make_carla.sh',
  input: 'make_carla.sh.in',
  configuration: global_conf,
  )

make_lsp_dsp_lib = configure_file (
  output: 'make_lsp_dsp_lib.sh',
  input: 'make_lsp_dsp_lib.sh.in',
  configuration: global_conf,
  )

get_pkg_filename = configure_file (
  output: 'get_pkg_filename.sh',
  input: 'get_pkg_filename.sh.in',
  configuration: global_conf,
  )

get_pkg_filename_from_distro = configure_file (
  output: 'get_pkg_filename_from_distro.sh',
  input: 'get_pkg_filename_from_distro.sh.in',
  configuration: global_conf,
  )

make_zplugins = configure_file (
  output: 'make_zplugins.sh',
  input: 'make_zplugins.sh.in',
  configuration: global_conf,
  )
