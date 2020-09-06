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

# configure script
make_zrythm_tarball = configure_file (
  output: 'make_zrythm_tarball.sh',
  input: 'make_zrythm_tarball.sh.in',
  configuration: global_conf,
  )

orig_zrythm_src_tarball = custom_target (
  'orig-zrythm-source-tarball',
  output: orig_zrythm_src_tarball_filename,
  command: [
    'wget', orig_zrythm_src_tarball_url, '-O', '@OUTPUT@',
    ],
  install: false,
  )

zrythm_src_tarball = custom_target (
  'zrythm-source-tarball',
  output: zrythm_src_tarball_filename,
  input: [
    make_zrythm_tarball, orig_zrythm_src_tarball,
    ],
  command: [
    bash, '-c', '@INPUT0@ "$1" "$2" "$3"', '_ignored',
    '@OUTPUT@', '@INPUT1@', '@PRIVATE_DIR@'
    ],
  install: false,
  )

run_target (
  'zrythm-src-tarball',
  command: [ 'echo', 'done' ],
  depends: zrythm_src_tarball)

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

url = 'https://github.com/falkTX/Carla/archive/' + carla_git_ver + '.zip'
carla_src_zip = custom_target (
  'carla-source-tarball',
  output: 'Carla-' + carla_git_ver + '.zip',
  command: [
    'wget', url, '-O', '@OUTPUT@',
    ],
  install: false,
  )

url = 'https://git.zrythm.org/cgit/zplugins/snapshot/zplugins-' + zplugins_ver + '.tar.gz'
zplugins_src_tarball = custom_target (
  'zplugins-source-tarball',
  output: zplugins_src_tarball_filename,
  command: [
    'wget', url, '-O', '@OUTPUT@',
    ],
  install: false,
  )

url = 'https://github.com/sadko4u/lsp-dsp-lib/releases/download/lsp-dsp-lib-' + lsp_dsp_lib_ver + '/lsp-dsp-lib-' + lsp_dsp_lib_ver + '-src.tar.gz'
lsp_dsp_lib_src_tarball = custom_target (
  'lsp-dsp-lib-source-tarball',
  output: 'lsp-dsp-lib-' + lsp_dsp_lib_ver + '.tar.gz',
  command: [
    'wget', url, '-O', '@OUTPUT@',
    ],
  install: false,
  )

filename = 'rcedit-x64.exe'
url = 'https://github.com/electron/rcedit/releases/download/v1.1.1/' + filename
rcedit_x64_exe = custom_target (
  'rcedit-x64-exe',
  output: filename,
  command: [
    bash, '-c',
    'wget ' + url + ' -O \'@OUTPUT@\' && ' +
    'chmod +x \'@OUTPUT@\''
    ],
  install: false,
  )
