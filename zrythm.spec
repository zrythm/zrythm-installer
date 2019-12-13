#
# Copyright (C) 2019 Alexandros Theodotou
#
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.

Name:          zrythm
Version:       0.7.093
Release:       1%{?dist}
Summary: An highly automated, intuitive, Digital Audio Workstation (DAW)
License:       AGPLv3+
URL:           https://www.zrythm.org
Source0:       https://git.zrythm.org/cgit/zrythm/snapshot/zrythm-v%{version}.tar.gz
BuildRequires: gcc-c++ gcc pkgconfig
BuildRequires: gtk3-devel >= 3.24
BuildRequires: python3
BuildRequires: lilv-devel
BuildRequires: lv2-devel
BuildRequires: libsndfile-devel
BuildRequires: libyaml-devel
BuildRequires: libsamplerate-devel
BuildRequires: gettext sed
BuildRequires: alsa-lib-devel
BuildRequires: ladspa-devel
BuildRequires: fftw-devel
BuildRequires: portaudio-devel
BuildRequires: meson
BuildRequires: help2man
Requires: gtk3 >= 3.24
Requires: ladspa
Requires: lilv libsamplerate
Requires: lv2
Requires: libyaml
Requires: libsndfile
Requires: alsa-lib
Requires: fftw
Requires: portaudio
%if 0%{?suse_version}
BuildRequires: jack-devel libX11-devel update-desktop-files
BuildRequires: fftw3-threads-devel
Requires:      jack
%endif
%if 0%{?fedora_version}
BuildRequires: jack-audio-connection-kit-devel libX11-devel qt5-devel
Requires:      jack-audio-connection-kit qt5
%endif
%if 0%{?mageia}
BuildRequires: libjack-devel libx11-devel qt5-devel
Requires:      jack
%endif
%description
Zrythm is a native GNU/Linux application built with
the GTK+3 toolkit and using the JACK Connection Kit for audio I/O.
Zrythm can automate plugin parameters using built in LFOs and envelopes
and is designed to be intuitive to use.


%prep
%autosetup -n zrythm-v%{version}

%build
rm -rf build
%if 0%{?suse_version}
meson build --prefix=/usr -Denable_tests=true -Dmanpage=true
%endif
%if 0%{?fedora_version}
# todo with qt5
meson build --prefix=/usr -Denable_tests=true -Dmanpage=true
%endif
%if 0%{?mageia}
# todo with qt5
meson build --prefix=/usr -Denable_tests=true -Dmanpage=true
%endif
ninja -C build

%install
DESTDIR="%{buildroot}/" ninja -C build install
%find_lang %{name}

%files -f %{name}.lang
%license COPYING
%doc README.md CONTRIBUTING.md INSTALL.md CHANGELOG.md
%{_bindir}/zrythm
%{_datadir}/applications/%{name}.desktop
%{_datadir}/fonts/%{name}
%{_datadir}/glib-2.0/schemas/*.xml
%{_datadir}/icons/hicolor/scalable/apps/%{name}.svg
%{_datadir}/%{name}
%{_datadir}/man/man1/zrythm.*
%{_datadir}/mime/packages/org.zrythm.Zrythm-mime.xml

%post
%if ! 0%{?suse_version}
  xdg-desktop-menu forceupdate
%endif

%postun
%if ! 0%{?suse_version}
  xdg-desktop-menu forceupdate
%endif
%changelog
* Sun Nov 03 2019 Alexandros Theodotou
- v0.7.093
