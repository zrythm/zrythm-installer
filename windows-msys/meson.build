# Copyright (C) 2020-2023 Alexandros Theodotou <alex at zrythm dot org>
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

windows_msys_conf = configuration_data ()
windows_msys_conf.set (
  'BASH', bash.full_path ())
windows_msys_conf.set (
  'DASH_TRIAL', dash_trial)
windows_msys_conf.set (
  'ZPLUGINS_VER', zplugins_ver)
windows_msys_conf.set (
  'ZRYTHM_PKG_VERSION', zrythm_pkg_ver)
windows_msys_conf.set (
  'ZRYTHM_PKG_SEMVER_VERSION', zrythm_pkg_semver)
windows_msys_conf.set (
  'TRIAL_TRUE_FALSE', trial_true_false)
windows_msys_conf.set (
  'CARLA_GIT_VER', carla_git_ver)
windows_msys_conf.set (
  'ZRYTHM_INNER_DIR_NAME', zrythm_inner_dir_name)
windows_msys_conf.set (
  'ZRYTHM_SOURCE_TARBALL_FILENAME',
  zrythm_src_tarball_filename)
windows_msys_conf.set (
  'SUPPORTING_TEXT',
  build_trial ? 'trying out' : 'supporting')
windows_msys_conf.set (
  'MINGW_PKG_PREFIX', mingw_pkg_prefix)
windows_msys_conf.set (
  'MINGW_PREFIX', mingw_prefix)
windows_msys_conf.set (
  'MINGW_ARCH', mingw_arch)
windows_msys_conf.set (
  'MESON_SOURCE_ROOT', meson_src_root)
windows_msys_conf.set (
  'GTK_VER', gtk_ver)
windows_msys_conf.set (
  'LIBADWAITA_VER', libadwaita_ver)
windows_msys_conf.set (
  'LIBPANEL_VER', libpanel_ver)
windows_msys_conf.set (
  'LSP_DSP_LIB_VER', lsp_dsp_lib_ver)
windows_msys_conf.set (
  'MARCH_MTUNE', get_option ('march_mtune'))
windows_msys_conf.set ('IS_TAG', is_tag ? 'true' : 'false')

mingw_zrythm_pkgbuild = configure_file (
  output: 'PKGBUILD',
  input: 'PKGBUILD.in',
  configuration: windows_msys_conf,
  )
mingw_carla_pkgbuild = configure_file (
  output: 'PKGBUILD-carla-mingw',
  input: 'PKGBUILD-carla-mingw.in',
  configuration: windows_msys_conf,
  )
mingw_cairo_pkgbuild = configure_file (
  output: 'PKGBUILD-cairo-mingw',
  input: 'PKGBUILD-cairo-mingw.in',
  configuration: windows_msys_conf,
  )
mingw_gtk4_pkgbuild = configure_file (
  output: 'PKGBUILD-gtk4-mingw',
  input: 'PKGBUILD-gtk4-mingw.in',
  configuration: windows_msys_conf,
  )
mingw_libadwaita_pkgbuild = configure_file (
  output: 'PKGBUILD-libadwaita-mingw',
  input: 'PKGBUILD-libadwaita-mingw.in',
  configuration: windows_msys_conf,
  )
mingw_libpanel_pkgbuild = configure_file (
  output: 'PKGBUILD-libpanel-mingw',
  input: 'PKGBUILD-libpanel-mingw.in',
  configuration: windows_msys_conf,
  )
mingw_lsp_dsp_lib_pkgbuild = configure_file (
  output: 'PKGBUILD-lsp-dsp-lib-mingw',
  input: 'PKGBUILD-lsp-dsp-lib-mingw.in',
  configuration: windows_msys_conf,
  )

# configure scripts
make_windows_chroot = configure_file (
  output: 'make_windows_chroot.sh',
  input: 'make_windows_chroot.sh.in',
  configuration: windows_msys_conf,
  )
collect_dlls = configure_file (
  output: 'collect_dlls.sh',
  input: 'collect_dlls.sh.in',
  configuration: windows_msys_conf,
  )
make_dist_dir = configure_file (
  output: 'make_dist_dir.sh',
  input: 'make_dist_dir.sh.in',
  configuration: windows_msys_conf,
  )
make_windows_installer = configure_file (
  output: 'make_windows_installer.sh',
  input: 'make_windows_installer.sh.in',
  configuration: windows_msys_conf,
  )
make_mingw_pkg = configure_file (
  output: 'make_mingw_pkg.sh',
  input: 'make_mingw_pkg.sh.in',
  configuration: windows_msys_conf,
  )
make_zrythm_mingw_pkg = configure_file (
  output: 'make_zrythm_mingw_pkg.sh',
  input: 'make_zrythm_mingw_pkg.sh.in',
  configuration: windows_msys_conf,
  )

filename = 'Carla-' + carla_git_ver + '.tar.gz'
url = 'https://github.com/falkTX/Carla/archive/' + carla_git_ver + '.zip'
carla_zip_orig_src = custom_target (
  'carla-zip-orig_src',
  output: 'carla-zip-orig-src-' + carla_git_ver + '.zip',
  command: [
    bash, '-c', 'wget "$1" -O "$2"',
    '_ignored',
    url, '@OUTPUT@',
    ],
  install: false,
  )
carla_zip_windows = custom_target (
  'carla-zip-windows',
  output: filename,
  input: carla_zip_orig_src,
  command: [
    bash, '-c',
    'rm -rf "$3" && mkdir -p "$3" && cp "$1" "$3"/"$2" && ' +
      'cd "$3" && rm -rf "$4" && unzip "$2" && ' +
      'cd "$4" && pwd && make msys2fix && cd .. && ' +
      'tar cvf "$2" "$4" && cd ../.. && mv "$3"/"$2" "$5" && ' +
      'echo "done"',
    '_ignored',
    '@INPUT@', filename, '@PRIVATE_DIR@',
    'Carla-' + carla_git_ver, '@OUTPUT@',
    ],
  install: false,
  )

make_mingw_pkg_cmd = [
  bash, '-c', '@INPUT0@ "$1" "$2" "$3" "$4" ' +
  '"$5" "$6"',
  '_ignored',
  '@OUTPUT@', '@INPUT1@', '@PRIVATE_DIR@',
  mingw_arch, '', '',
  ]
make_mingw_pkg_cmd_full = [
  bash, '-c', '@INPUT0@ "$1" "$2" "$3" "$4" ' +
  '"$5" "$6"',
  '_ignored',
  '@OUTPUT@', '@INPUT1@', '@PRIVATE_DIR@',
  mingw_arch, '', '@INPUT2@',
  ]

# sources
inno_extract_ver = '1.9'
filename = 'innoextract-' + inno_extract_ver + '-windows.zip'
url = 'https://github.com/dscharrer/innoextract/releases/download/' + inno_extract_ver + '/' + filename
inno_extract_zip = custom_target (
  'inno-extract-zip',
  output: filename,
  command: [
    'wget', url, '-O', '@OUTPUT@',
    ],
  install: false,
  )
#inno_extract = custom_target (
  #'inno-extract-exe',
  #output: 'innoextract.exe',
  #input: inno_extract_ver,
  #command: [
    #bash, '-c', '@INPUT0@ "$1" "$2" "$3"', '_ignored',
    #'@OUTPUT@', '@INPUT1@', '@PRIVATE_DIR@'
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

cv2pdb_version = '0.52'
filename = 'cv2pdb-' + cv2pdb_version + '.zip'
url = 'https://github.com/rainers/cv2pdb/releases/download/v' + cv2pdb_version + '/' + filename
cv2pdb_zip = custom_target (
  'cv2pdb-zip',
  output: filename,
  command: [
    'wget', url, '-O', '@OUTPUT@',
    ],
  install: false,
  )

filename = 'drmingw-0.9.11-win64.zip'
url = 'https://www.zrythm.org/downloads/drmingw-0.9.11-win64.zip'
drmingw_zip = custom_target (
  'drmingw-zip',
  output: filename,
  command: [
    'wget', url, '-O', '@OUTPUT@',
    ],
  install: false,
  )

# install dependencies
carla_packages = []
foreach arch : [ 'ucrt64', 'mingw32' ]
#foreach arch : [ '32' ]
  carla_pkg_target = custom_target (
  'mingw-carla-' + arch,
  output: 'carla-' + arch + '.pkg.tar.zst',
  input: [
    make_mingw_pkg, mingw_carla_pkgbuild,
    carla_zip_windows,
    ],
  command: [
    bash, '-c',
    '@INPUT0@ "$1" "$2" "$3" "$4" "$5" "$6"',
    '_ignored',
    '@OUTPUT@', '@INPUT1@', '@PRIVATE_DIR@',
    arch,
    '@INPUT2@',
    ],
  console: true,
  install: false,
  )
  carla_packages += carla_pkg_target
  run_target (
    'mingw-carla-' + arch + '-build',
    command: [ 'echo', 'done', ],
    depends: carla_pkg_target)
endforeach
sratom_pkg = custom_target (
  'mingw-sratom',
  output: 'sratom.pkg.tar.zst',
  input: [ make_mingw_pkg, 'PKGBUILD-sratom-mingw', ],
  command: make_mingw_pkg_cmd,
  console: true,
  install: false,
  )
lilv_pkg = custom_target (
  'mingw-lilv',
  output: 'lilv.pkg.tar.zst',
  input: [ make_mingw_pkg, 'PKGBUILD-lilv-mingw', ],
  command: make_mingw_pkg_cmd,
  depends: sratom_pkg,
  console: true,
  install: false,
  )
run_target (
  'run-mingw-lilv',
  command: [ 'echo', 'done' ],
  depends: lilv_pkg)
cairo_pkg = custom_target (
  'mingw-cairo',
  output: 'cairo.pkg.tar.zst',
  input: [ make_mingw_pkg, mingw_cairo_pkgbuild, ],
  command: make_mingw_pkg_cmd,
  console: true,
  install: false,
  )
run_target (
  'run-mingw-cairo',
  command: [ 'echo', 'done' ],
  depends: cairo_pkg)
gtk4_pkg = custom_target (
  'mingw-gtk4',
  output: 'gtk4.pkg.tar.zst',
  input: [ make_mingw_pkg, mingw_gtk4_pkgbuild, ],
  command: make_mingw_pkg_cmd,
  console: true,
  install: false,
  )
run_target (
  'run-mingw-gtk4',
  command: [ 'echo', 'done' ],
  depends: gtk4_pkg)
appstream_pkg = custom_target (
  'mingw-appstream',
  output: 'appstream.pkg.tar.zst',
  input: [ make_mingw_pkg, 'PKGBUILD-appstream-mingw', ],
  command: make_mingw_pkg_cmd,
  console: true,
  install: false,
  )
libadwaita_pkg = custom_target (
  'mingw-libadwaita',
  output: 'libadwaita.pkg.tar.zst',
  input: [ make_mingw_pkg, mingw_libadwaita_pkgbuild, ],
  command: make_mingw_pkg_cmd,
  depends: [ gtk4_pkg, ],
  console: true,
  install: false,
  )
run_target (
  'run-mingw-libadwaita',
  command: [ 'echo', 'done' ],
  depends: libadwaita_pkg)

libpanel_pkg = custom_target (
  'mingw-libpanel',
  output: 'libpanel.pkg.tar.zst',
  input: [ make_mingw_pkg, mingw_libpanel_pkgbuild, ],
  command: make_mingw_pkg_cmd,
  # don't depend on libadwaita/gtk anymore - use upstream packages
  #depends: libadwaita_pkg,
  console: true,
  install: false,
  )
run_target (
  'run-mingw-libpanel',
  command: [ 'echo', 'done' ],
  depends: libpanel_pkg)

lsp_dsp_lib_pkg = custom_target (
  'mingw-lsp-dsp-lib',
  output: 'lsp-dsp-lib.pkg.tar.zst',
  input: [ make_mingw_pkg, mingw_lsp_dsp_lib_pkgbuild, ],
  command: make_mingw_pkg_cmd,
  console: true,
  install: false,
  )
run_target (
  'run-mingw-lsp-dsp-lib',
  command: [ 'echo', 'done' ],
  depends: lsp_dsp_lib_pkg)

libbacktrace_pkg = custom_target (
  'mingw-libbacktrace',
  output: 'libbacktrace.pkg.tar.zst',
  input: [ make_mingw_pkg, 'PKGBUILD-libbacktrace', ],
  command: make_mingw_pkg_cmd,
  console: true,
  install: false,
  )
run_target (
  'run-mingw-libbacktrace',
  command: [ 'echo', 'done' ],
  depends: libbacktrace_pkg)

mingw_zrythm_pkg = custom_target (
  'mingw-zrythm-pkg',
  output: 'zrythm' + dash_trial + '.pkg.tar.zst',
  input: [
    make_zrythm_mingw_pkg, mingw_zrythm_pkgbuild,
    zrythm_src_tarball, zplugins_src_tarball,
    drmingw_zip,
    ],
  command: [
    bash, '-c',
    '@INPUT0@ "$1" "$2" "$3" "$4" "$5" "$6"', '_ignored',
    '@OUTPUT@', '@INPUT1@', '@INPUT2@',
    '@INPUT3@', '@PRIVATE_DIR@', '@INPUT4@',
    ],
  depends: [
    lsp_dsp_lib_pkg, libpanel_pkg,
    ],
  console: true,
  install: false,
  )

run_target (
  'install-zrythm-mingw-pkg',
  command: [ 'echo', 'done' ],
  depends: mingw_zrythm_pkg)

chroot_dir = meson.current_build_dir () / 'zrythm' + dash_trial + '-chroot'
windows_chroot_target = custom_target (
  'windows-chroot',
  output: 'zrythm-test',
  input: [
    make_windows_chroot, zrythm_src_tarball,
    carla_packages[0],
    carla_packages[1],
    lsp_dsp_lib_pkg,
    mingw_zrythm_pkg,
    ],
  command: [
    bash, '-c',
    '@INPUT0@ "$1" "$2" "$3" "$4" "$5" "$6" ' +
    '"$7" "$8" "$9" "${10}" "${11}"',
    '_ignored',
    '@OUTPUT@', chroot_dir, '@INPUT1@', '@INPUT2@',
    '@INPUT3@', '@INPUT4@', '@INPUT5@',
    ],
  console: true,
  install: false,
  )

dll_dir = custom_target (
  'windows-msys-dll-dir',
  output: 'dlls',
  input: [
    collect_dlls, 'copy-dll-deps.sh',
    ],
  command: [
    bash, '-c',
    '@INPUT0@ "$1" "$2" "$3"',
    '_ignored',
    '@OUTPUT@', '@INPUT1@', chroot_dir,
    ],
  depends: [
    windows_chroot_target,
    ],
  console: true,
  install: false,
  )

run_target (
  'windows-msys-prepare',
  command: [ 'echo', 'done' ],
  depends: dll_dir)

mingw_packages_url = 'https://github.com/msys2/MINGW-packages'
mingw_packages_commit_res = run_command (
  bash, '-c', 'git ls-remote "$1" | grep HEAD | head -n1 | awk \'{print $1;}\'',
  '_ignored', mingw_packages_url,
  capture: true, check: true)
mingw_packages_commit = mingw_packages_commit_res.stdout().split ('HEAD')[0].strip()
mingw_packages_zip = custom_target (
  'mingw-packages-' + mingw_packages_commit + '-zip',
  output: 'MINGW-packages-' + mingw_packages_commit + '.zip',
  command: [
    bash, '-c', 'wget "$1" -O "$2"',
    '_ignored',
    mingw_packages_url + '/archive/' + mingw_packages_commit + '.zip',
    '@OUTPUT@',
    ],
  install: false,
  )

installer_dist_dir = custom_target (
  'windows-installer-dist-dir',
  output: 'installer-dist',
  input: [
    make_dist_dir, zrythm_src_tarball,
    'copy-dll-deps.sh',
    rcedit_x64_exe, dll_dir,
    carla_zip_windows,
    mingw_packages_zip,
    demo_project_zip, cv2pdb_zip,
    drmingw_zip,
    ],
  command: [
    bash, '-c',
    '@INPUT0@ "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" ' +
    '"$9" "${10}" "${11}" "${12}" "${13}"',
    '_ignored',
    '@OUTPUT@', '@INPUT1@', chroot_dir,
    '@PRIVATE_DIR@', '@INPUT2@', '@INPUT3@',
    '@INPUT4@', '@INPUT5@', '@INPUT6@',
    mingw_packages_commit, '@INPUT7@', '@INPUT8@',
    '@INPUT9@',
    ],
  console: true,
  install: false,
  )

iscc_exe_rel_path = '.wine/drive_c/Program Files (x86)/Inno Setup 6/ISCC.exe'
iscc_exe_abs_path = meson.current_build_dir () / iscc_exe_rel_path
install_inno_setup = custom_target (
  'install-inno-setup-target',
  output: 'installed-inno-setup',
  command: [
    bash, '-c', 'set -xe ; mkdir -p "$1" ; pushd "$1" ; if ! test -f "$2" ; then ' +
    'wget "$3" ; unzip "$5" -d ./ ; fi ; popd; touch "$4"',
    '_ignored',
    meson.current_build_dir (), iscc_exe_rel_path,
    'https://www.zrythm.org/downloads/inno-setup-bin.zip', '@OUTPUT@',
    'inno-setup-bin.zip',
    ],
  install: false,
  )
run_target (
  'install-inno-setup',
  command: [ 'echo', 'done', ],
    depends: install_inno_setup)


windows_msys_installer_filename = run_command (
  bash, '-c',
  meson.build_root () / 'scripts/get_pkg_filename.sh' +
  ' WINDOWS_MSYS ' + dash_trial).stdout ().strip ()
windows_msys_installer = custom_target (
  'windows-msys-installer',
  output: windows_msys_installer_filename,
  input: [
    make_windows_installer, installer_dist_dir,
    'installer.iss',
    ],
  command: [
    bash, '-c',
    '@INPUT0@ "$1" "$2" "$3" "$4"', '_ignored',
    '@OUTPUT@', '@INPUT1@', '@INPUT2@',
    iscc_exe_abs_path,
    ],
  depends: install_inno_setup,
  console: true,
  install: true,
  install_dir: get_option ('prefix'),
  )
