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

rpm_conf = configuration_data ()
rpm_conf.merge_from (global_conf)
rpm_conf.set (
  'BUILT_ZPLUGINS_DIR', zplugins_installation.full_path ())

specfile = configure_file (
  output: 'zrythm.spec',
  input: 'zrythm.spec.in',
  configuration: rpm_conf,
  )

rpm_pkg_filename = run_command (
  get_pkg_filename, 'FEDORA', dash_trial).stdout ().strip ()
rpm_pkg = custom_target (
  'rpm-pkg',
  output: rpm_pkg_filename,
  input: [
    specfile, zrythm_src_tarball,
    ],
  command: [
    make_rpm_pkg, '@OUTPUT@', '@INPUT0@', '@INPUT1@',
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
  'rpm',
  command: [ 'echo', 'done' ],
  depends: rpm_pkg)
