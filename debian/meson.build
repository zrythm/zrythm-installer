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
debian_conf = configuration_data ()
debian_conf.set (
  'MESON_BIN', meson_bin)
debian_conf.set (
  'BASH', bash.full_path ())
debian_conf.set (
  'DASH_TRIAL', dash_trial)
debian_conf.set (
  'ZPLUGINS_VER', zplugins_ver)
debian_conf.set (
  'ZRYTHM_PKG_VERSION', zrythm_pkg_ver)
debian_conf.set (
  'TRIAL_TRUE_FALSE', trial_true_false)
debian_conf.set (
  'ZRYTHM_INNER_DIR_NAME', zrythm_inner_dir_name)
debian_conf.set (
  'ZRYTHM_SOURCE_TARBALL_FILENAME',
  zrythm_src_tarball_filename)
debian_conf.set (
  'CARLA_DESTDIR',
  carla_installation.full_path ())
debian_conf.set (
  'CARLA_PKG_CONFIG_PATH',
  carla_pkgconfig_path)
debian_conf.set (
  'CARLA_PREFIX', carla_prefix)
debian_conf.set (
  'CARLA_FULL_BINS_PATH', carla_installation.full_path () + carla_prefix / 'carla')
debian_conf.set (
  'BUILT_ZPLUGINS_DIR',
  zplugins_installation.full_path ())
debian_conf.set ('LIBDIR', libdir)
debian_conf.set (
  'LIBRARY_PKG_CONFIG_PATH',
  library_pkgconfig_path)

# configure files
debian_changelog = configure_file (
  output: 'changelog',
  input: 'changelog.in',
  configuration: debian_conf,
  )
debian_control = configure_file (
  output: 'control',
  input: 'control.in',
  configuration: debian_conf,
  )
debian_rules = configure_file (
  output: 'rules',
  input: 'rules.in',
  configuration: debian_conf,
  )
make_debian_pkg = configure_file (
  output: 'make_debian_pkg.sh',
  input: 'make_debian_pkg.sh.in',
  configuration: debian_conf,
  )

# sources
debian_zrythm_src_tarball = custom_target (
  'debian-zrythm-source-tarball',
  output: debian_src_tarball_filename.split ('.gz')[0],
  input: zrythm_src_tarball,
  command: [
    'rm', '-rf', '@OUTPUT@', '&&',
    # rezip because gzip says not valid gzip format
    'tar', 'xf', '@INPUT@', '&&',
    'tar', 'cf', '@OUTPUT@', zrythm_inner_dir_name, '&&',
    'rm', '-rf', zrythm_inner_dir_name,
    ],
  install: false,
  )
debian_zrythm_src_tarball_gzipped = custom_target (
  'debian-zrythm-source-tarball-gzipped',
  output: debian_src_tarball_filename,
  input: debian_zrythm_src_tarball,
  command: [
    'rm', '-rf', '@OUTPUT@', '&&',
    'gzip', '@INPUT@',
    ],
  install: false,
  )

# package
debian_pkg_filename = run_command (
  get_pkg_filename, 'DEBIAN', dash_trial).stdout ().strip ()
debian_pkg = custom_target (
  'debian-pkg',
  output: debian_pkg_filename,
  input: [
    debian_zrythm_src_tarball_gzipped,
    debian_changelog, debian_rules,
    'compat', debian_control, 'copyright',
    ],
  command: [
    make_debian_pkg, '@OUTPUT@', '@INPUT0@', '@INPUT1@',
    '@INPUT2@', '@INPUT3@', '@INPUT4@',
    '@INPUT5@', debian_pkg_filename,
    ],
  depends: [
    debian_zrythm_src_tarball_gzipped,
    carla_installation,
    lsp_dsp_lib_installation,
    zrythm_src_tarball,
    zplugins_installation,
    ],
  console: true,
  install: true,
  install_dir: get_option ('prefix'),
  )

run_target (
  'debian',
  command: [ 'echo', 'done' ],
  depends: debian_pkg)
