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

arch_conf = configuration_data ()
arch_conf.merge_from (global_conf)
arch_conf.set (
  'BUILT_ZPLUGINS_DIR', zplugins_installation.full_path ())
arch_conf.set (
  'CARLA_PKG_CONFIG_PATH', carla_pkgconfig_path)
arch_conf.set (
  'CARLA_FULL_BINS_PATH',
  carla_installation.full_path () + carla_prefix / 'carla')

pkgbuild = configure_file (
  output: 'PKGBUILD',
  input: 'PKGBUILD.in',
  configuration: arch_conf,
  )

arch_pkg_filename = run_command (
  get_pkg_filename, 'ARCH', dash_trial).stdout ().strip ()
arch_pkg = custom_target (
  'arch-pkg',
  output: arch_pkg_filename,
  input: [
    pkgbuild, zrythm_src_tarball,
    ],
  command: [
    make_arch_pkg, '@OUTPUT@', '@INPUT0@', '@INPUT1@',
    zrythm_src_tarball_filename, arch_pkg_filename,
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

manual_deps = []
if not build_trial
  foreach lang : locales
    filename = 'Zrythm-' + zrythm_pkg_ver + '-' + lang + '.pdf'
    manual_deps += custom_target (
      'user-manuals-' + lang,
      output: filename,
      input: zrythm_src_tarball,
      command: [
        make_user_manual, '@OUTPUT@', '@INPUT0@',
        zrythm_src_tarball_filename, lang,
        '@PRIVATE_DIR@',
        ],
      install: true,
      install_dir: get_option ('prefix') / 'manuals',
      )
  endforeach
endif

run_target (
  'arch-pkg',
  command: [ 'echo', 'done' ],
  depends: [ arch_pkg ])

run_target (
  'arch',
  command: [ 'echo', 'done' ],
  depends: [ arch_pkg, manual_deps ])
