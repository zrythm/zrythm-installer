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
  input: orig_zrythm_src_tarball,
  command: [
    bash, '-c',
    'private_dir=@PRIVATE_DIR@ && ' +
    'rm -rf $private_dir && ' +
    'mkdir -p $private_dir && ' +
    'cp ' + orig_zrythm_src_tarball.full_path () + ' $private_dir/ && ' +
    'pushd $private_dir && ' +
    'tar xf ' + orig_zrythm_src_tarball_filename + ' && ' +
    'mv ' + orig_inner_dir_name + ' ' +
    zrythm_inner_dir_name + ' && ' +
    'tar czf tmp.tar.gz ' + zrythm_inner_dir_name +
    ' && popd && ' +
    'cp "$private_dir/tmp.tar.gz" ' +
    meson.current_build_dir () / zrythm_src_tarball_filename
    ],
  install: false,
  )

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
