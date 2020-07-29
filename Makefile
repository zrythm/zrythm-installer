#
#  Copyright (C) 2019-2020 Alexandros Theodotou <alex at zrythm dot org>
#
#  This file is part of Zrythm
#
#  Zrythm is free software: you can redistribute it and/or modify
#  it under the terms of the GNU Affero General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  Zrythm is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU Affero General Public License for more details.
#
#  You should have received a copy of the GNU Affero General Public License
#  along with Zrythm.  If not, see <https://www.gnu.org/licenses/>.

# git tag/commit
ZRYTHM_VERSION=master
# version to use in packages
ZRYTHM_PKG_VERSION=1
ZRYTHM_TARBALL=zrythm-$(ZRYTHM_VERSION).tar.gz
ZRYTHM_PKG_TARBALL=zrythm-$(ZRYTHM_PKG_VERSION).tar.gz
ZRYTHM_DIR=zrythm-$(ZRYTHM_PKG_VERSION)
ZPLUGINS_VERSION=0.1.2
ZPLUGINS_TARBALL=zplugins-$(ZPLUGINS_VERSION).tar.gz
ZPLUGINS_TARBALL_URL=https://git.zrythm.org/cgit/zplugins/snapshot/zplugins-v$(ZPLUGINS_VERSION).tar.gz
ZPLUGINS_DIR=zplugins-$(ZPLUGINS_VERSION)
ZLFO_MANIFEST=ZLFO.lv2/manifest.ttl
ZRYTHM_DEBIAN_TARBALL_TAR=zrythm_$(ZRYTHM_PKG_VERSION).orig.tar
ZRYTHM_DEBIAN_TARBALL=zrythm_$(ZRYTHM_PKG_VERSION).orig.tar.gz
ZRYTHM_TRIAL_DEBIAN_TARBALL_TAR=zrythm-trial_$(ZRYTHM_PKG_VERSION).orig.tar
ZRYTHM_TRIAL_DEBIAN_TARBALL=zrythm-trial_$(ZRYTHM_PKG_VERSION).orig.tar.gz
SUM_EXT=sha256sum
ZRYTHM_TARBALL_SUM=zrythm-$(ZRYTHM_VERSION).tar.gz.$(SUM_EXT)
CALC_SUM=sha256sum --check
ZRYTHM_TARBALL_URL=https://git.zrythm.org/cgit/zrythm/snapshot/zrythm-$(ZRYTHM_VERSION).tar.gz
CARLA_VERSION=6a783076e89b878339190aeb60477d21a9596068
CARLA_SOURCE_URL=https://github.com/falkTX/Carla/archive/$(CARLA_VERSION).zip
CARLA_SOURCE_ZIP=Carla-$(CARLA_VERSION).zip
CARLA_WINDOWS_BINARY_64_ZIP=carla-64-$(shell echo $(CARLA_VERSION) | head -c 7).zip
CARLA_WINDOWS_BINARY_32_ZIP=carla-2.2.0-rc1-woe32.zip
CARLA_WINDOWS_BINARY_64_URL=https://www.zrythm.org/downloads/carla/$(CARLA_WINDOWS_BINARY_64_ZIP)
CARLA_WINDOWS_BINARY_32_URL=https://www.zrythm.org/downloads/carla/$(CARLA_WINDOWS_BINARY_32_ZIP)
ARCH_MXE_ROOT=/home/ansible/Documents/git/mxe
ARCH_MXE_64_STATIC_PREFIX=$(ARCH_MXE_ROOT)/usr/x86_64-w64-mingw32.static
ARCH_MXE_64_SHARED_PREFIX=$(ARCH_MXE_ROOT)/usr/x86_64-w64-mingw32.shared
MXE_FLAGS_SHARED=MXE_TARGETS='x86_64-w64-mingw32.shared' MXE_PLUGIN_DIRS=$(ARCH_MXE_ROOT)/plugins/meson-wrapper -j3 JOBS=4
MXE_FLAGS_STATIC=MXE_TARGETS='x86_64-w64-mingw32.static' MXE_PLUGIN_DIRS=$(ARCH_MXE_ROOT)/plugins/meson-wrapper -j3 JOBS=4
MXE_ZPLUGINS_CLONE_PATH=/home/ansible/Documents/git/ZPlugins
MXE_GTK3_CLONE_PATH=/home/ansible/Documents/non-git/gtk+-3.24.18
BUILD_DIR=build
MESON_VERSION=0.55.0
MESON_DIR=meson-$(MESON_VERSION)
MESON_TARBALL=$(MESON_DIR).tar.gz
BUILD_ARCH_DIR=$(BUILD_DIR)/archlinux
BUILD_WINDOWS_DIR=$(BUILD_DIR)/windows10
BUILD_WINDOWS_MSYS_DIR=$(BUILD_DIR)/windows10-msys
BUILD_OSX_DIR=$(BUILD_DIR)/osx
BUILD_OSX_BREW_DIR=$(BUILD_DIR)/osx-brew-zip
WINDOWS_CHROOT_BASE=/tmp/chroot-for-zrythm
WIN_CHROOT_DIR=/tmp/zrythm-root
WIN_TRIAL_CHROOT_DIR=/tmp/zrythm-trial-root
# This is the directory to rsync into
MINGW_SRC_DIR=../../msys64/home/alex/zrythm-build
WINDOWS_ZRYTHM_PKG_TAR_XZ=
RPMBUILD_ROOT=/home/ansible/rpmbuild
BUILD_FEDORA32_DIR=$(BUILD_DIR)/fedora32
BUILD_OPENSUSE_TUMBLEWEED_DIR=$(BUILD_DIR)/opensuse-tumbleweed
ARCH_PKG_FILE=zrythm-$(ZRYTHM_PKG_VERSION)-1-x86_64.pkg.tar.zst
ARCH_TRIAL_PKG_FILE=zrythm-trial-$(ZRYTHM_PKG_VERSION)-1-x86_64.pkg.tar.zst
DEBIAN_PKG_FILE=zrythm_$(ZRYTHM_PKG_VERSION)-1_amd64.deb
DEBIAN_TRIAL_PKG_FILE=zrythm-trial_$(ZRYTHM_PKG_VERSION)-1_amd64.deb
FEDORA32_PKG_FILE=zrythm-$(ZRYTHM_PKG_VERSION)-1.fc32.x86_64.rpm
FEDORA32_TRIAL_PKG_FILE=zrythm-trial-$(ZRYTHM_PKG_VERSION)-1.fc32.x86_64.rpm
OPENSUSE_TUMBLEWEED_PKG_FILE=zrythm-$(ZRYTHM_PKG_VERSION)-1.opensuse-tumbleweed.x86_64.rpm
OPENSUSE_TUMBLEWEED_TRIAL_PKG_FILE=zrythm-trial-$(ZRYTHM_PKG_VERSION)-1.opensuse-tumbleweed.x86_64.rpm
WINDOWS_INSTALLER=zrythm-$(ZRYTHM_PKG_VERSION)-setup.exe
WINDOWS_TRIAL_INSTALLER=zrythm-trial-$(ZRYTHM_PKG_VERSION)-setup.exe
WINDOWS_MSYS_INSTALLER=zrythm-$(ZRYTHM_PKG_VERSION)-ms-setup.exe
WINDOWS_MSYS_TRIAL_INSTALLER=zrythm-trial-$(ZRYTHM_PKG_VERSION)-ms-setup.exe
WINDOWS_PKG_FILE=$(WINDOWS_INSTALLER)
WINDOWS_TRIAL_PKG_FILE=$(WINDOWS_TRIAL_INSTALLER)
WINDOWS_MSYS_PKG_FILE=$(WINDOWS_MSYS_INSTALLER)
WINDOWS_MSYS_TRIAL_PKG_FILE=$(WINDOWS_MSYS_TRIAL_INSTALLER)
GNU_PLAYBOOK=playbook.yml
WOE_PLAYBOOK=woe-playbook.yml
ANSIBLE_PLAYBOOK_CMD=ansible-playbook -i ./ansible-conf.ini --extra-vars "version=$(ZRYTHM_PKG_VERSION) zplugins_version=$(ZPLUGINS_VERSION) meson_version=$(MESON_VERSION) carla_version=$(CARLA_VERSION)" -v
WINDOWS_IP=192.168.100.178
ARCH_IP=192.168.100.142
ZRYTHM_MINGW_REVISION=2
MINGW_ZRYTHM_PKG_TAR=mingw-w64-x86_64-zrythm-$(ZRYTHM_PKG_VERSION)-$(ZRYTHM_MINGW_REVISION)-any.pkg.tar.zst
MINGW_ZRYTHM_TRIAL_PKG_TAR=mingw-w64-x86_64-zrythm-trial-$(ZRYTHM_PKG_VERSION)-$(ZRYTHM_MINGW_REVISION)-any.pkg.tar.zst
MINGW_ZPLUGINS_PKG_TAR=mingw-w64-zplugins-$(ZPLUGINS_VERSION)-1-any.pkg.tar.xz
MINGW_ZPLUGINS_TRIAL_PKG_TAR=mingw-w64-zplugins-trial-$(ZPLUGINS_VERSION)-1-any.pkg.tar.xz
MINGW_ZRYTHM_SRC=/tmp/makepkg/mingw-w64-zrythm/src/zrythm-$(ZRYTHM_PKG_VERSION)
MINGW_ZPLUGINS_SRC=/tmp/makepkg/mingw-w64-zplugins/src/zplugins-$(ZPLUGINS_VERSION)
MINGW_PREFIX=/usr/x86_64-w64-mingw32
MSYS_MINGW_PREFIX=/mingw64
RCEDIT64_EXE=rcedit-x64.exe
RCEDIT64_VER=1.1.1
RCEDIT64_URL=https://github.com/electron/rcedit/releases/download/v$(RCEDIT64_VER)/$(RCEDIT64_EXE)
UNIX_INSTALLER_ZIP=zrythm-$(ZRYTHM_PKG_VERSION)-installer.zip
UNIX_TRIAL_INSTALLER_ZIP=zrythm-trial-$(ZRYTHM_PKG_VERSION)-installer.zip
GNU_LINUX_PKG_FILE=$(UNIX_INSTALLER_ZIP)
GNU_LINUX_TRIAL_PKG_FILE=$(UNIX_TRIAL_INSTALLER_ZIP)
COMMON_SRC_DEPS=$(BUILD_DIR)/$(ZPLUGINS_TARBALL) $(BUILD_DIR)/$(ZRYTHM_PKG_TARBALL) $(BUILD_DIR)/meson/meson.py $(BUILD_DIR)/$(CARLA_SOURCE_ZIP)
OSX_INSTALL_PREFIX=/tmp/zrythm-osx
OSX_INSTALL_TRIAL_PREFIX=/tmp/zrythm-trial-osx
OSX_INSTALLER=zrythm-$(ZRYTHM_PKG_VERSION)-setup.dmg
OSX_PKG_FILE=$(OSX_INSTALLER)
OSX_TRIAL_INSTALLER=zrythm-trial-$(ZRYTHM_PKG_VERSION)-setup.dmg
OSX_TRIAL_PKG_FILE=$(OSX_TRIAL_INSTALLER)
OSX_BREW_BOTTLE=zrythm--$(ZRYTHM_PKG_VERSION).catalina.bottle.tar.gz
OSX_TRIAL_BREW_BOTTLE=zrythm-trial--$(ZRYTHM_PKG_VERSION).catalina.bottle.tar.gz
OSX_BREW_ZIP_PKG_FILE=zrythm-$(ZRYTHM_PKG_VERSION)-osx-installer.zip
OSX_BREW_ZIP_TRIAL_PKG_FILE=zrythm-trial-$(ZRYTHM_PKG_VERSION)-osx-installer.zip
CARLA_BOTTLE_VER=0.1.2
CARLA_BOTTLE=carla-git--$(CARLA_BOTTLE_VER).catalina.bottle.tar.gz
APPIMAGE_APPDIR=/tmp/appimage/AppDir
BREEZE_DARK_PATH=/Users/alex/.local/share/icons/breeze-dark
MANUAL_ZIP_PATH=$(BUILD_DIR)/user-manual.zip
BUILD_ZPLUGINS_DIR=$(BUILD_DIR)/zplugins
ZSAW_MANIFEST_PATH=$(BUILD_DIR)/zplugins/ZSaw.lv2/manifest.ttl

define start_vm
	if sudo virsh list | grep -q " $(1) .*paused" ; then \
	sudo virsh resume $(1); \
	elif ! sudo virsh list | grep -q "$(1)" ; then \
		sudo virsh start $(1); \
		sleep 25; \
	fi
endef

define stop_vm
	sudo virsh shutdown $(1)
endef

# arg 1: VM name
define run_build_in_vm
	$(call start_vm,$(1))
	$(ANSIBLE_PLAYBOOK_CMD) -l $(1) $(GNU_PLAYBOOK)
	cd artifacts/$(1) && unzip -o zplugins.zip && \
		rm zplugins.zip
	cd artifacts/$(1) && unzip -o zplugins-trial.zip && \
		rm zplugins-trial.zip
	$(call stop_vm,$(1))
endef

define run_windows_build_in_vm
	$(call start_vm,archlinux)
	$(ANSIBLE_PLAYBOOK_CMD) -l archlinux $(WOE_PLAYBOOK)
	$(call stop_vm,archlinux)
endef

# creates the artifacts for unix
# argument 1: the installer zip filename
# argument 2: `-trial` if trial, otherwise empty
# argument 3: dependency (make trial depend on non-trial so
# they are not run in parallel)
define create_installer_zip_target
${1}: tools/gen_installer.sh README$(2).in installer.sh.in FORCE ${3}
	tools/gen_installer.sh $(ZRYTHM_PKG_VERSION) $(1) $(ZPLUGINS_VERSION) $(2)
endef

.PHONY: FORCE
FORCE:

# runs everything and produces the installer zip
$(eval $(call create_installer_zip_target,$(UNIX_INSTALLER_ZIP),))
$(eval $(call create_installer_zip_target,$(UNIX_TRIAL_INSTALLER_ZIP),-trial,$(UNIX_INSTALLER_ZIP)))

artifacts/windows10/$(WINDOWS_INSTALLER) artifacts/windows10/$(WINDOWS_TRIAL_INSTALLER) &: $(COMMON_SRC_DEPS) $(BUILD_DIR)/$(RCEDIT64_EXE)
	$(call run_windows_build_in_vm))

# 1: prefix
# 2: sudo or empty
# 3: suffix
define make_carla
	export PKG_CONFIG_PATH=/usr/lib/zrythm/lib/pkgconfig && \
	if pkg-config --atleast-version=2.1 carla-native-plugin ; then \
		echo "latest carla installed" ; \
	fi
	cd $(BUILD_DIR) && unzip -o $(CARLA_SOURCE_ZIP) && \
		cd Carla-$(CARLA_VERSION) && \
		make -j4 && $(2) make install PREFIX=$(1)$(3)
endef

define remove_carla
	cd $(BUILD_DIR)/Carla-$(CARLA_VERSION) && \
		sudo make uninstall PREFIX=$(1)$(3)
endef

# arg 1: prefix
# arg 2: trial version true/false
define make_osx
	cd $(BUILD_OSX_DIR) && tar xf $(ZRYTHM_PKG_TARBALL) && \
		cd zrythm-$(ZRYTHM_PKG_VERSION) && \
		rm -rf build && \
		PKG_CONFIG_PATH=$(1)/lib/zrythm/lib/pkgconfig \
		meson build -Dsdl=enabled -Drtaudio=auto \
		  -Drtmidi=auto -Dffmpeg=enabled \
			-Dmac_release=true -Dtrial_ver=$(2) \
			-Djack=disabled -Dgraphviz=enabled \
			-Dcarla=enabled -Dmanpage=false \
			--prefix=$(1) && \
		ninja -C build && ninja -C build install
endef

$(OSX_INSTALL_PREFIX)/bin/zrythm $(OSX_INSTALL_TRIAL_PREFIX)/bin/zrythm&: $(BUILD_DIR)/$(ZRYTHM_PKG_TARBALL) $(BUILD_DIR)/$(CARLA_SOURCE_ZIP)
	-rm -rf $(BUILD_OSX_DIR)/$(ZRYTHM_PKG_TARBALL)
	-rm -rf $(OSX_INSTALL_PREFIX)
	mkdir -p $(BUILD_OSX_DIR)
	cp $(BUILD_DIR)/$(ZRYTHM_PKG_TARBALL) $(BUILD_OSX_DIR)/$(ZRYTHM_PKG_TARBALL)
	$(call make_carla,$(OSX_INSTALL_TRIAL_PREFIX),,/lib/zrythm)
	$(call make_osx,$(OSX_INSTALL_TRIAL_PREFIX),true)
	$(call make_carla,$(OSX_INSTALL_PREFIX),,/lib/zrythm)
	$(call make_osx,$(OSX_INSTALL_PREFIX),false)

# this must be run on macos
artifacts/osx/$(OSX_INSTALLER) artifacts/osx/$(OSX_TRIAL_INSTALLER)&: tools/gen_osx_installer.sh $(OSX_INSTALL_PREFIX)/bin/zrythm $(OSX_INSTALL_TRIAL_PREFIX)/bin/zrythm tools/osx/launcher.sh tools/osx/appdmg.json.in
	tools/gen_osx_installer.sh $(ZRYTHM_PKG_VERSION) \
		$(BUILD_OSX_DIR)/zrythm-$(ZRYTHM_PKG_VERSION) \
		$(OSX_INSTALL_PREFIX) \
		artifacts/osx/$(OSX_INSTALLER) \
		$$(pwd)/tools/osx /usr/local \
		Zrythm Zrythm $(BREEZE_DARK_PATH) \
		$(MANUAL_ZIP_PATH)
	tools/gen_osx_installer.sh $(ZRYTHM_PKG_VERSION) \
		$(BUILD_OSX_DIR)/zrythm-$(ZRYTHM_PKG_VERSION) \
		$(OSX_INSTALL_TRIAL_PREFIX) \
		artifacts/osx/$(OSX_TRIAL_INSTALLER) \
		$$(pwd)/tools/osx /usr/local \
		"Zrythm (Trial)" Zrythm-trial $(BREEZE_DARK_PATH)

.PHONY: osx
osx: artifacts/osx/$(OSX_INSTALLER) artifacts/osx/$(OSX_TRIAL_INSTALLER)

# 1: brew bottle
# 2: dep
define make_osx_brew_bottle_target
$(BUILD_OSX_BREW_DIR)/$(1): tools/gen_osx_installer_brew.sh tools/osx/zrythm.rb $(BUILD_DIR)/$(ZRYTHM_TARBALL) $(2)
	mkdir -p $(BUILD_OSX_BREW_DIR)
	rm -rf /tmp/breeze-dark
	cp -R $(BREEZE_DARK_PATH) /tmp/breeze-dark
	tools/gen_osx_installer_brew.sh bottle "$$@" tools/osx/zrythm.rb $(BUILD_DIR)/$(ZRYTHM_TARBALL) $(ZRYTHM_PKG_VERSION) $(CARLA_VERSION) $(CARLA_BOTTLE_VER)
	touch $$@
endef

$(eval $(call make_osx_brew_bottle_target,$(OSX_BREW_BOTTLE)))
$(eval $(call make_osx_brew_bottle_target,$(OSX_TRIAL_BREW_BOTTLE),$(BUILD_OSX_BREW_DIR)/$(OSX_BREW_BOTTLE)))

$(BUILD_OSX_BREW_DIR)/$(OSX_BREW_ZIP_PKG_FILE): $(BUILD_OSX_BREW_DIR)/$(OSX_BREW_BOTTLE)
	tools/gen_osx_installer_brew.sh zip "$<" "$@" $(ZRYTHM_PKG_VERSION) $(CARLA_BOTTLE_VER) $(BUILD_OSX_BREW_DIR)/$(CARLA_BOTTLE)

$(BUILD_OSX_BREW_DIR)/$(OSX_BREW_ZIP_TRIAL_PKG_FILE): $(BUILD_OSX_BREW_DIR)/$(OSX_TRIAL_BREW_BOTTLE) $(BUILD_OSX_BREW_DIR)/$(OSX_BREW_ZIP_PKG_FILE)
	tools/gen_osx_installer_brew.sh zip "$<" "$@" $(ZRYTHM_PKG_VERSION) $(CARLA_BOTTLE_VER) $(BUILD_OSX_BREW_DIR)/$(CARLA_BOTTLE)

.PHONY: osx-brew-zip
osx-brew-zip: $(BUILD_OSX_BREW_DIR)/$(OSX_BREW_ZIP_PKG_FILE) $(BUILD_OSX_BREW_DIR)/$(OSX_BREW_ZIP_TRIAL_PKG_FILE)

#
# Function to get the full path to the ZSaw manifest file
# for a specific distro
#
# 1: distro name
#
get_zsaw_manifest_target=$(BUILD_DIR)/$(1)/zplugins/ZSaw.lv2/manifest.ttl

#
# Zplugins source target
#
$(BUILD_DIR)/zplugins-v$(ZPLUGINS_VERSION)/meson.build: $(BUILD_DIR)/$(ZPLUGINS_TARBALL)
	rm -rf $(BUILD_DIR)/zplugins-v$(ZPLUGINS_VERSION)
	cd $(BUILD_DIR) && tar xf $(ZPLUGINS_TARBALL)

# arg 1: distro
# arg 2: optional tmpdir suffix
# arg 3: gcc prefix
define make_zplugins
	rm -rf /tmp/$(2)/usr/lib/lv2/Z*.lv2
	cd $(BUILD_DIR) && tar xf $(ZPLUGINS_TARBALL)
	cd $(BUILD_DIR)/zplugins-v$(ZPLUGINS_VERSION) && \
		cd ext/Soundpipe && CC=$(3)gcc make && cd ../.. && \
		../meson/meson.py build --buildtype=release \
		--prefix=/usr && \
		DESTDIR=/tmp ninja -C build install
	mkdir -p $(BUILD_DIR)/$(1)/zplugins
	cp -R /tmp/$(2)/usr/lib/lv2/Z*.lv2 $(BUILD_DIR)/$(1)/zplugins
	ls -l $(BUILD_DIR)/$(1)/zplugins/Z*.lv2
endef

# 1: distro name (debian10,ubuntu2004,...)
# 2: base distro in caps (DEBIAN,FEDORA32,...)
define make_distro_target
$(call make_distro_zplugins_target,$(1))

$(call get_zsaw_manifest_target,$(1)): $(BUILD_DIR)/zplugins-v$(ZPLUGINS_VERSION)/meson.build
	$$(call make_zplugins,$(1),)

.PHONY: $(1)
$(1): $(BUILD_DIR)/$(1)/$($(2)_PKG_FILE) $(BUILD_DIR)/$(1)/$($(2)_TRIAL_PKG_FILE) $(call get_zsaw_manifest_target,$(1))
endef

# 1: distro name
define prepare_debian
	rm -rf $(BUILD_DIR)/$(1)/$(ZRYTHM_DIR)
	mkdir -p $(BUILD_DIR)/$(1)
	cp $(BUILD_DIR)/$(ZRYTHM_PKG_TARBALL) $(BUILD_DIR)/$(1)/$(ZRYTHM_DEBIAN_TARBALL)
	cp $(BUILD_DIR)/$(ZRYTHM_PKG_TARBALL) $(BUILD_DIR)/$(1)/$(ZRYTHM_TRIAL_DEBIAN_TARBALL)
	# rezip because gzip says not valid gzip format
	cd $(BUILD_DIR)/$(1) && tar xf $(ZRYTHM_DEBIAN_TARBALL) && \
		tar cf $(ZRYTHM_DEBIAN_TARBALL_TAR) $(ZRYTHM_DIR) && \
		tar cf $(ZRYTHM_TRIAL_DEBIAN_TARBALL_TAR) $(ZRYTHM_DIR) && \
		rm $(ZRYTHM_DEBIAN_TARBALL) && gzip $(ZRYTHM_DEBIAN_TARBALL_TAR) && \
		rm $(ZRYTHM_TRIAL_DEBIAN_TARBALL) && gzip $(ZRYTHM_TRIAL_DEBIAN_TARBALL_TAR)
	mkdir -p $(BUILD_DIR)/$(1)/$(ZRYTHM_DIR)/debian/source
	cp debian.changelog.in $(BUILD_DIR)/$(1)/$(ZRYTHM_DIR)/debian/changelog
	sed -i -e 's/@VERSION@/$(ZRYTHM_PKG_VERSION)/' $(BUILD_DIR)/$(1)/$(ZRYTHM_DIR)/debian/changelog
	cp debian.compat $(BUILD_DIR)/$(1)/$(ZRYTHM_DIR)/debian/compat
	cp debian.control $(BUILD_DIR)/$(1)/$(ZRYTHM_DIR)/debian/control
	cp debian.copyright $(BUILD_DIR)/$(1)/$(ZRYTHM_DIR)/debian/copyright
	cp debian.rules $(BUILD_DIR)/$(1)/$(ZRYTHM_DIR)/debian/rules
	sed -i -e 's/@VERSION@/$(ZRYTHM_PKG_VERSION)/' $(BUILD_DIR)/$(1)/$(ZRYTHM_DIR)/debian/rules
	if [ "$$(hostname)" = "linuxmint193" ] ; then \
			sed -i -e 's/-Dffmpeg=enabled/-Dffmpeg=disabled/' $(BUILD_DIR)/$(1)/$(ZRYTHM_DIR)/debian/rules; \
			sed -i -e 's/ninja test/echo test/' $(BUILD_DIR)/$(1)/$(ZRYTHM_DIR)/debian/rules; \
		fi
	echo "3.0 (quilt)" > $(BUILD_DIR)/$(1)/$(ZRYTHM_DIR)/debian/source/format
endef

# 1: pkg filename
# 2: distro (debian10,ubuntu1804,...)
# 3: "-trial" for trial
# 4: dependency (to make trial depend on full)
define make_debian_pkg_target
$(BUILD_DIR)/$(2)/$(1): debian.changelog.in debian.compat debian.control debian.copyright debian.rules $(COMMON_SRC_DEPS) $(4)
	$$(call make_carla,/usr,sudo,/lib/zrythm)
	$$(call prepare_debian,$(2))
	if [ "$(3)" = "-trial" ]; then \
		cd $(BUILD_DIR)/$(2)/$(ZRYTHM_DIR) && \
		sed -i -e '8s/$$$$/ -Dtrial_ver=true/' debian/rules && \
		sed -i -e 's|debian/zrythm|debian/zrythm-trial|' debian/rules && \
		sed -i -e '1s/zrythm/zrythm-trial/' debian/changelog && \
		sed -i -e 's/: zrythm/: zrythm-trial/g' debian/control ; \
	fi
	cd $(BUILD_DIR)/$(2)/$(ZRYTHM_DIR) && debuild -us -uc
endef

# 1: distro (debian10,ubuntu1804,...)
define make_debian_target
$(call make_debian_pkg_target,$(DEBIAN_PKG_FILE),$(1),,)
$(call make_debian_pkg_target,$(DEBIAN_TRIAL_PKG_FILE),$(1),-trial,)

$(call make_distro_target,$(1),DEBIAN)
endef

$(eval $(call make_debian_target,debian10))
$(eval $(call make_debian_target,debian11))
$(eval $(call make_debian_target,ubuntu1804))
$(eval $(call make_debian_target,ubuntu2004))
$(eval $(call make_debian_target,ubuntu2010))

# 1: pkg filename
# 2: distro (debian10,ubuntu1804,...)
# 3: "-trial" for trial
# 4: dependency (to make trial depend on full)
define make_arch_pkg_target
$(BUILD_DIR)/$(2)/$(1): PKGBUILD.in $(COMMON_SRC_DEPS) $(4)
	$$(call make_carla,/usr,sudo,/lib/zrythm)
	mkdir -p $(BUILD_ARCH_DIR)
	cp PKGBUILD.in $(BUILD_ARCH_DIR)/PKGBUILD
	cp $(BUILD_DIR)/$(ZRYTHM_PKG_TARBALL) $(BUILD_ARCH_DIR)/
	sed -i -e 's/@VERSION@/$(ZRYTHM_PKG_VERSION)/g' $(BUILD_ARCH_DIR)/PKGBUILD
	if [ "$(3)" = "-trial" ]; then \
		sed -i -e '2s/zrythm/zrythm-trial/' $(BUILD_ARCH_DIR)/PKGBUILD ; \
		sed -i -e 's/-Dtrial_ver=false/-Dtrial_ver=true/' $(BUILD_ARCH_DIR)/PKGBUILD ; \
	else \
		cd $(BUILD_DIR) && tar xf $(ZRYTHM_PKG_TARBALL) && \
			cd zrythm-$(ZRYTHM_PKG_VERSION) && \
			meson build && \
			sed -i -e 's/latexpdf/latex/' doc/user/meson.build && \
			ninja -C build latex-manual-en latex-manual-fr latex-manual-de && \
			make -C build/doc/user/en/latex && \
			make -C build/doc/user/fr/latex && \
			make -C build/doc/user/de/latex ; \
	fi
	cd $(BUILD_ARCH_DIR) && makepkg -f
	rm -rf $(BUILD_ARCH_DIR)/src/zrythm-$(ZRYTHM_VERSION)
endef

# 1: distro (debian10,ubuntu1804,...)
define make_arch_target
$(call make_arch_pkg_target,$(ARCH_PKG_FILE),$(1),,)
$(call make_arch_pkg_target,$(ARCH_TRIAL_PKG_FILE),$(1),-trial,)
$(call make_distro_target,$(1),ARCH)
endef

$(eval $(call make_arch_target,archlinux))

# 1: pkg filename
# 2: distro (debian10,ubuntu1804,...)
# 3: "-trial" for trial
# 4: dependency (to make trial depend on full)
define make_rpm_pkg_target
$(BUILD_DIR)/$(2)/$(1): zrythm.spec.in $(COMMON_SRC_DEPS) $(4)
	$$(call make_carla,/usr,sudo,/lib/zrythm)
	rm -rf $(RPMBUILD_ROOT)/BUILDROOT/*
	mkdir -p $(RPMBUILD_ROOT) && \
		cd $(RPMBUILD_ROOT) && \
		mkdir -p BUILD BUILDROOT RPMS SOURCES SPECS SRPMS
	mkdir -p $(BUILD_DIR)/$(2)
	cp zrythm.spec.in $(RPMBUILD_ROOT)/SPECS/zrythm.spec
	sed -i -e 's/@VERSION@/$(ZRYTHM_PKG_VERSION)/g' $(RPMBUILD_ROOT)/SPECS/zrythm.spec
	cp $(BUILD_DIR)/$(ZRYTHM_PKG_TARBALL) \
		$(RPMBUILD_ROOT)/SOURCES/
	if [ "$(3)" = "-trial" ]; then \
		sed -i -e '9s/zrythm/zrythm-trial/' $(RPMBUILD_ROOT)/SPECS/zrythm.spec ; \
		sed -i -e 's/-Dtrial_ver=false/-Dtrial_ver=true/' $(RPMBUILD_ROOT)/SPECS/zrythm.spec ; \
	fi
	rpmbuild -ba $(RPMBUILD_ROOT)/SPECS/zrythm.spec
	cp $(RPMBUILD_ROOT)/RPMS/x86_64/$(1) $$@
endef

# 1: distro (debian10,ubuntu1804,...)
define make_rpm_target
$(call make_rpm_pkg_target,$(FEDORA32_PKG_FILE),$(1),,)
$(call make_rpm_pkg_target,$(FEDORA32_TRIAL_PKG_FILE),$(1),-trial,)
$(call make_distro_target,$(1),FEDORA32)
endef

$(eval $(call make_rpm_target,fedora32))

# create AppImage target
# arg 1: '-trial' if trial
# arg 2: 'true' if trial, 'false' if not
define make_appimg_target
$(BUILD_DIR)/Zrythm$(1)-$(ZRYTHM_PKG_VERSION)-x86_64.AppImage: $(BUILD_DIR)/$(ZRYTHM_PKG_TARBALL) $(BUILD_DIR)/meson/meson.py
	rm -rf $(APPIMAGE_APPDIR)
	rm -rf /tmp/zrythm$(1)-appimg
	mkdir -p $(APPIMAGE_APPDIR)
	mkdir -p /tmp/zrythm$(1)-appimg
	cp $(BUILD_DIR)/$(ZRYTHM_PKG_TARBALL) /tmp/zrythm$(1)-appimg/
	BUILD_DIR_PATH=$$$$(pwd)/$(BUILD_DIR) && \
	MESON_PATH=$$$$BUILD_DIR_PATH/meson && \
		echo "meson path is $$$$MESON_PATH" && \
		cd /tmp/zrythm$(1)-appimg && tar xf $(ZRYTHM_PKG_TARBALL) && \
		cd zrythm-$(ZRYTHM_PKG_VERSION) && \
		$$$$MESON_PATH/meson.py build -Dsdl=enabled -Drtaudio=auto \
		  -Drtmidi=auto -Dffmpeg=enabled \
			-Dguile=enabled \
			-Dtrial_ver=$(2) --prefix=/usr && \
		ninja -C build && DESTDIR=$(APPIMAGE_APPDIR) ninja -C build install && \
		wget -c "https://raw.githubusercontent.com/linuxdeploy/linuxdeploy-plugin-gtk/master/linuxdeploy-plugin-gtk.sh" && \
		wget -c "https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage" && \
		chmod +x linuxdeploy-plugin-gtk.sh && \
		chmod +x linuxdeploy-x86_64.AppImage && \
		rm -f $(APPIMAGE_APPDIR)/usr/share/glib-2.0/schemas/gschemas.compiled && \
		sed -i -e 's/Exec=.*zrythm_launch/Exec=zrythm_launch/' $(APPIMAGE_APPDIR)/usr/share/applications/zrythm.desktop && \
		sed -i -e 's|/usr|$$$$(dirname "$$$$0")/usr|' $(APPIMAGE_APPDIR)/usr/bin/zrythm_launch && \
		./linuxdeploy-x86_64.AppImage --appdir $(APPIMAGE_APPDIR) --plugin gtk --output appimage --icon-file=$(APPIMAGE_APPDIR)/usr/share/icons/hicolor/scalable/apps/zrythm.svg --desktop-file $(APPIMAGE_APPDIR)/usr/share/applications/zrythm.desktop && \
	cp Zrythm-x86_64.AppImage $$$$BUILD_DIR_PATH/Zrythm$(1)-$(ZRYTHM_PKG_VERSION)-x86_64.AppImage
endef

$(eval $(call make_appimg_target,,false))
$(eval $(call make_appimg_target,-trial,true))

.PHONY: windows10
windows10: $(BUILD_DIR)/$(WINDOWS_TRIAL_INSTALLER) $(BUILD_DIR)/$(WINDOWS_INSTALLER)

.PHONY: windows10-msys
windows10-msys: $(BUILD_DIR)/$(WINDOWS_MSYS_TRIAL_INSTALLER) $(BUILD_DIR)/$(WINDOWS_MSYS_INSTALLER)

# target for zplugins mingw packages on windows
$(BUILD_WINDOWS_DIR)/plugins/$(MINGW_ZPLUGINS_TRIAL_PKG_TAR): arch-mingw/zplugins-PKGBUILD.in $(COMMON_SRC_DEPS)
	rm -rf $(BUILD_WINDOWS_DIR)/plugins
	mkdir -p $(BUILD_WINDOWS_DIR)/plugins
	cp arch-mingw/zplugins-PKGBUILD.in $(BUILD_WINDOWS_DIR)/plugins/PKGBUILD
	sed -i -e 's/@VERSION@/$(ZPLUGINS_VERSION)/' $(BUILD_WINDOWS_DIR)/plugins/PKGBUILD
	cd $(BUILD_WINDOWS_DIR)/plugins && \
		cp ../../$(ZPLUGINS_TARBALL) ./ && \
		makepkg -f
	# make trial
	sed -i -e '2s/zplugins/zplugins-trial/' $(BUILD_WINDOWS_DIR)/plugins/PKGBUILD
	sed -i -e 's/-Dtrial_ver=false/-Dtrial_ver=true/' $(BUILD_WINDOWS_DIR)/plugins/PKGBUILD
	cd $(BUILD_WINDOWS_DIR)/plugins && makepkg -f

# arg 1: '-trial' if trial
# arg 2: 'true' if trial, false otherwise
define make_zrythm_mxe_target
$(ARCH_MXE_64_SHARED_PREFIX)/bin/zrythm$(1).exe:
	cd $(ARCH_MXE_ROOT) && \
		sed -i -e 's/-Dtrial_ver=false/-Dtrial_ver=$(2)/' src/zrythm.mk && \
		sed -i -e 's/-Dtrial_ver=true/-Dtrial_ver=$(2)/' src/zrythm.mk && \
		sed -i -e 's/_VERSION  .*/_VERSION  := $(ZRYTHM_VERSION)/' src/zrythm.mk && \
		./bootstrap && \
		make $(MXE_FLAGS_STATIC) fluidsynth && \
		make update-checksum-zrythm && \
		make $(MXE_FLAGS_SHARED) zrythm
	if [ "$(1)" = "-trial" ]; then \
		mv $(ARCH_MXE_64_SHARED_PREFIX)/bin/zrythm.exe \
			$(ARCH_MXE_64_SHARED_PREFIX)/bin/zrythm$(1).exe ; \
	fi

#$(ARCH_MXE_64_SHARED_PREFIX)/bin/zrythm$(1).exe: $(ARCH_MXE_64_STATIC_PREFIX)/bin/zrythm$(1).exe
endef

$(ARCH_MXE_64_STATIC_PREFIX)/lib/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-svg.dll: $(ARCH_MXE_64_STATIC_PREFIX)/bin/zrythm.exe
	mkdir -p $(ARCH_MXE_64_STATIC_PREFIX)/lib/gdk-pixbuf-2.0/2.10.0/loaders
	cp $(ARCH_MXE_64_SHARED_PREFIX)/lib/gdk-pixbuf-2.0/2.10.0/loaders/*.dll \
		$(ARCH_MXE_64_STATIC_PREFIX)/lib/gdk-pixbuf-2.0/2.10.0/loaders/

$(eval $(call make_zrythm_mxe_target,,false))
$(eval $(call make_zrythm_mxe_target,-trial,true))

# 1: package
define install_lilv_dep
	mkdir -p $(BUILD_WINDOWS_MSYS_DIR)
	cp PKGBUILD-$(1)-mingw $(BUILD_WINDOWS_MSYS_DIR)/PKGBUILD
	cd $(BUILD_WINDOWS_MSYS_DIR) && MINGW_INSTALLS=mingw64 makepkg-mingw -fsi --noconfirm
endef

install-lilv-dep-%:
	$(call install_lilv_dep,$*)

/mingw64/include/lilv-0/lilv/lilv.h: PKGBUILD-lilv-mingw PKGBUILD-lv2-mingw PKGBUILD-serd-mingw PKGBUILD-sord-mingw PKGBUILD-sratom-mingw PKGBUILD-jack2-mingw
	$(call install_lilv_dep,lv2)
	$(call install_lilv_dep,serd)
	$(call install_lilv_dep,sord)
	$(call install_lilv_dep,sratom)
	$(call install_lilv_dep,lilv)
	$(call install_lilv_dep,jack2)

# arg 1: .pkg.tar filename
# arg 2: '-trial' if trial
# arg 3: dependency (make trial depend on main ver)
define make_zrythm_msys_target
$(BUILD_WINDOWS_MSYS_DIR)/$(1): PKGBUILD-w10.in $(3) $(BUILD_DIR)/$(CARLA_WINDOWS_BINARY_64_ZIP) $(BUILD_DIR)/$(CARLA_WINDOWS_BINARY_32_ZIP) $(BUILD_DIR)/$(ZPLUGINS_TARBALL) $(BUILD_DIR)/$(ZRYTHM_PKG_TARBALL) $(BUILD_DIR)/meson/meson.py /mingw64/include/lilv-0/lilv/lilv.h
	# install carla
	cd $(BUILD_DIR) && \
		unzip -o $(CARLA_WINDOWS_BINARY_64_ZIP) -d \
		/mingw64/
	cd $(BUILD_DIR) && \
		unzip -o $(CARLA_WINDOWS_BINARY_32_ZIP) -d \
		/mingw64/lib/carla/
	# prepare
	rm -rf $(BUILD_WINDOWS_MSYS_DIR)/src
	mkdir -p $(BUILD_WINDOWS_MSYS_DIR)/src
	cp PKGBUILD-w10.in $(BUILD_WINDOWS_MSYS_DIR)/PKGBUILD
	cp $(BUILD_DIR)/$(ZRYTHM_PKG_TARBALL) $(BUILD_WINDOWS_MSYS_DIR)/
	cp $(BUILD_DIR)/$(ZPLUGINS_TARBALL) $(BUILD_WINDOWS_MSYS_DIR)/
	sed -i -e 's/@VERSION@/$(ZRYTHM_PKG_VERSION)/g' $(BUILD_WINDOWS_MSYS_DIR)/PKGBUILD
	sed -i -e 's|@MESON@|$$(pwd)/$(BUILD_DIR)/meson/meson.py|g' $(BUILD_WINDOWS_MSYS_DIR)/PKGBUILD
	sed -i -e 's/@ZPLUGINS_VERSION@/$(ZPLUGINS_VERSION)/' $(BUILD_WINDOWS_MSYS_DIR)/PKGBUILD
	if [ "$(2)" = "-trial" ]; then \
		sed -i -e '2s/zrythm/zrythm-trial/' $(BUILD_WINDOWS_MSYS_DIR)/PKGBUILD ; \
		sed -i -e 's/-Dtrial_ver=false/-Dtrial_ver=true/' $(BUILD_WINDOWS_MSYS_DIR)/PKGBUILD ; \
	fi
	cd $(BUILD_WINDOWS_MSYS_DIR) && MINGW_INSTALLS=mingw64 makepkg-mingw -f
endef

$(eval $(call make_zrythm_msys_target,$(MINGW_ZRYTHM_PKG_TAR)))
$(eval $(call make_zrythm_msys_target,$(MINGW_ZRYTHM_TRIAL_PKG_TAR),-trial,$(BUILD_WINDOWS_MSYS_DIR)/$(MINGW_ZRYTHM_PKG_TAR)))

# arg 1: chroot dir
# arg 2: zrythm pkg tar
define make_windows_chroot
	rm -rf $(1) && \
	mkdir -p $(1)/var/lib/pacman && \
	mkdir -p $(1)/var/log && \
	mkdir -p $(1)/tmp && \
	pacman -Syu --root $(1) && \
	pacman -S filesystem bash pacman mingw-w64-x86_64-gtksourceview4 --noconfirm --needed --root $(1) && \
	pacman -U "$(BUILD_WINDOWS_MSYS_DIR)/mingw-w64-x86_64-lv2-1.18.0-1-any.pkg.tar.zst" --noconfirm --needed --root $(1) && \
	pacman -U "$(BUILD_WINDOWS_MSYS_DIR)/mingw-w64-x86_64-serd-0.30.4-1-any.pkg.tar.zst" --noconfirm --needed --root $(1) && \
	pacman -U "$(BUILD_WINDOWS_MSYS_DIR)/mingw-w64-x86_64-sord-0.16.4-1-any.pkg.tar.zst" --noconfirm --needed --root $(1) && \
	pacman -U "$(BUILD_WINDOWS_MSYS_DIR)/mingw-w64-x86_64-sratom-0.6.4-1-any.pkg.tar.zst" --noconfirm --needed --root $(1) && \
	pacman -U "$(BUILD_WINDOWS_MSYS_DIR)/mingw-w64-x86_64-lilv-0.24.8-1-any.pkg.tar.zst" --noconfirm --needed --root $(1) && \
	pacman -U "$(BUILD_WINDOWS_MSYS_DIR)/mingw-w64-x86_64-jack2-1.9.14.r1-1-any.pkg.tar.zst" --noconfirm --needed --root $(1) && \
	pacman -U $(2) --noconfirm --needed --root $(1) && \
	cp -R /mingw64/lib/carla $(1)/mingw64/lib/ && \
	glib-compile-schemas.exe $(1)/mingw64/share/glib-2.0/schemas
endef

# arg 1: installer filename
# arg 2: AppName
# arg 3: `-trial` if trial
define make_windows_msys_installer_target
$(BUILD_DIR)/$(1): $(BUILD_WINDOWS_MSYS_DIR)/$(MINGW_ZRYTHM_PKG_TAR) $(BUILD_WINDOWS_MSYS_DIR)/$(MINGW_ZRYTHM_TRIAL_PKG_TAR) $(BUILD_DIR)/$(ZRYTHM_PKG_TARBALL) $(BUILD_DIR)/$(RCEDIT64_EXE)
	# create sources distribution
	- rm -rf $(BUILD_WINDOWS_MSYS_DIR)/installer
	mkdir -p $(BUILD_WINDOWS_MSYS_DIR)/installer/dist/plugins
	# add thirdparty version info
	echo "TODO" > $(BUILD_WINDOWS_MSYS_DIR)/installer/dist/THIRDPARTY_INFO
	# copy other files
	cp $(BUILD_DIR)/$(ZRYTHM_PKG_TARBALL) /tmp && \
		cd /tmp && tar xf $(ZRYTHM_PKG_TARBALL)
	cp /tmp/zrythm-$(ZRYTHM_PKG_VERSION)/AUTHORS $(BUILD_WINDOWS_MSYS_DIR)/installer/dist/
	cp /tmp/zrythm-$(ZRYTHM_PKG_VERSION)/COPYING* $(BUILD_WINDOWS_MSYS_DIR)/installer/dist/
	cp /tmp/zrythm-$(ZRYTHM_PKG_VERSION)/README.md $(BUILD_WINDOWS_MSYS_DIR)/installer/dist/README.txt
	cp /tmp/zrythm-$(ZRYTHM_PKG_VERSION)/CONTRIBUTING.md $(BUILD_WINDOWS_MSYS_DIR)/installer/dist/
	cp /tmp/zrythm-$(ZRYTHM_PKG_VERSION)/THANKS $(BUILD_WINDOWS_MSYS_DIR)/installer/dist/
	cp /tmp/zrythm-$(ZRYTHM_PKG_VERSION)/TRANSLATORS $(BUILD_WINDOWS_MSYS_DIR)/installer/dist/
	cp /tmp/zrythm-$(ZRYTHM_PKG_VERSION)/CHANGELOG.md $(BUILD_WINDOWS_MSYS_DIR)/installer/dist/
	cp /tmp/zrythm-$(ZRYTHM_PKG_VERSION)/data/windows/zrythm.ico $(BUILD_WINDOWS_MSYS_DIR)/installer/dist/zrythm.ico
	cp $(BUILD_DIR)/$(RCEDIT64_EXE) $(BUILD_WINDOWS_MSYS_DIR)/installer/
	# create a chroot with all the required files
	if [ "$(3)" == "-trial" ]; then \
		$(call make_windows_chroot,/tmp/zrythm$(3),$(BUILD_WINDOWS_MSYS_DIR)/$(MINGW_ZRYTHM_TRIAL_PKG_TAR)) ; \
		cp /tmp/zrythm$(3)/mingw64/bin/zrythm.exe /tmp/zrythm$(3)/mingw64/bin/zrythm-trial.exe ; \
	else \
		$(call make_windows_chroot,/tmp/zrythm$(3),$(BUILD_WINDOWS_MSYS_DIR)/$(MINGW_ZRYTHM_PKG_TAR)) ; \
	fi
	# copy plugins
	cp -R \
		/tmp/zrythm$(3)/mingw64/lib/lv2/Z*.lv2 \
		$(BUILD_WINDOWS_MSYS_DIR)/installer/dist/plugins/
	# remove some plugins if trial ver
	if [ "$(3)" == "-trial" ]; then \
		rm -rf $(BUILD_WINDOWS_MSYS_DIR)/installer/dist/plugins/ZChordz*.lv2 ; \
		rm -rf $(BUILD_WINDOWS_MSYS_DIR)/installer/dist/plugins/ZLFO*.lv2 ; \
	fi
	# create installer
	chmod +x tools/gen_windows_installer.sh
	sed -i -e "s/sudo //g" tools/gen_windows_installer.sh
	tools/gen_windows_installer.sh /tmp/zrythm$(3)/mingw64 \
		$(ZRYTHM_PKG_VERSION) $(BUILD_WINDOWS_MSYS_DIR)/installer \
		$(shell pwd)/tools/inno/installer.iss "$(2)" \
		plugins "$(BREEZE_DARK_PATH)" \
		$(MANUAL_ZIP_PATH) $(3)
	cp "$(BUILD_WINDOWS_MSYS_DIR)/installer/dist/Output/$(2) $(ZRYTHM_PKG_VERSION).exe" $(BUILD_WINDOWS_MSYS_DIR)/$(1)
endef

$(eval $(call make_windows_msys_installer_target,$(WINDOWS_MSYS_INSTALLER),Zrythm))
$(eval $(call make_windows_msys_installer_target,$(WINDOWS_MSYS_TRIAL_INSTALLER),Zrythm Trial,-trial))

# arg 1: ignore
# arg 2: installer filename
# arg 3: AppName
# arg 4: `-trial` if trial
define make_windows_installer_target
$(BUILD_DIR)/$(2): $(ARCH_MXE_64_SHARED_PREFIX)/bin/zrythm$(4).exe $(ARCH_MXE_64_SHARED_PREFIX)/lib/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-svg.dll $(BUILD_DIR)/$(ZRYTHM_PKG_TARBALL) $(BUILD_DIR)/$(RCEDIT64_EXE)
	# create sources distribution
	- rm -rf $(BUILD_WINDOWS_DIR)/installer
	mkdir -p $(BUILD_WINDOWS_DIR)/installer/dist/plugins$(4)
	# copy plugins
	cp -R \
		$(ARCH_MXE_64_SHARED_PREFIX)/lib/lv2/Z*.lv2 \
		$(BUILD_WINDOWS_DIR)/installer/dist/plugins$(4)/
	# remove some plugins if trial ver
	if [ "$(4)" == "-trial" ]; then \
		rm -rf $(BUILD_WINDOWS_DIR)/installer/dist/plugins$(4)/ZChordz*.lv2 ; \
		rm -rf $(BUILD_WINDOWS_DIR)/installer/dist/plugins$(4)/ZLFO*.lv2 ; \
	fi
	# add thirdparty version info
	chmod +x tools/print_mxe_deps.sh
	tools/print_mxe_deps.sh \
		$(ARCH_MXE_ROOT) \
		$(BUILD_WINDOWS_DIR)/installer/dist/THIRDPARTY_INFO
	# copy other files
	cp $(BUILD_DIR)/$(ZRYTHM_PKG_TARBALL) /tmp && \
		cd /tmp && tar xf $(ZRYTHM_PKG_TARBALL)
	cp /tmp/zrythm-$(ZRYTHM_PKG_VERSION)/AUTHORS $(BUILD_WINDOWS_DIR)/installer/dist/
	cp /tmp/zrythm-$(ZRYTHM_PKG_VERSION)/COPYING* $(BUILD_WINDOWS_DIR)/installer/dist/
	cp /tmp/zrythm-$(ZRYTHM_PKG_VERSION)/README.md $(BUILD_WINDOWS_DIR)/installer/dist/README.txt
	cp /tmp/zrythm-$(ZRYTHM_PKG_VERSION)/CONTRIBUTING.md $(BUILD_WINDOWS_DIR)/installer/dist/
	cp /tmp/zrythm-$(ZRYTHM_PKG_VERSION)/THANKS $(BUILD_WINDOWS_DIR)/installer/dist/
	cp /tmp/zrythm-$(ZRYTHM_PKG_VERSION)/TRANSLATORS $(BUILD_WINDOWS_DIR)/installer/dist/
	cp /tmp/zrythm-$(ZRYTHM_PKG_VERSION)/CHANGELOG.md $(BUILD_WINDOWS_DIR)/installer/dist/
	cp /tmp/zrythm-$(ZRYTHM_PKG_VERSION)/data/windows/zrythm.ico $(BUILD_WINDOWS_DIR)/installer/dist/zrythm.ico
	cp $(BUILD_DIR)/$(RCEDIT64_EXE) $(BUILD_WINDOWS_DIR)/installer/
	# create installer
	chmod +x tools/gen_windows_installer.sh
	tools/gen_windows_installer.sh $(ARCH_MXE_64_SHARED_PREFIX) \
		$(ZRYTHM_PKG_VERSION) $(BUILD_WINDOWS_DIR)/installer \
		$(shell pwd)/tools/inno/installer.iss "$(3)" \
		plugins$(4) $(BREEZE_DARK_PATH) \
		$(MANUAL_ZIP_PATH) $(4)
	cp "$(BUILD_WINDOWS_DIR)/installer/dist/Output/$(3) $(ZRYTHM_PKG_VERSION).exe" $(BUILD_WINDOWS_DIR)/$(2)
endef

$(eval $(call make_windows_installer_target,,$(WINDOWS_INSTALLER),Zrythm))
$(eval $(call make_windows_installer_target,,$(WINDOWS_TRIAL_INSTALLER),Zrythm Trial,-trial))

# target to fetch latest version of git, used whenever
# the meson version is too old
.PHONY: meson
meson: $(BUILD_DIR)/meson/meson.py

$(BUILD_DIR)/meson/meson.py: $(BUILD_DIR)/$(MESON_TARBALL)
	rm -rf $(BUILD_DIR)/meson
	cd $(BUILD_DIR) && tar xf $(MESON_TARBALL) && mv $(MESON_DIR) meson

# target for fetching the zrythm release tarball
$(BUILD_DIR)/$(ZRYTHM_TARBALL):
	mkdir -p $(BUILD_DIR)
	wget $(ZRYTHM_TARBALL_URL) -O $@
	#wget $(ZRYTHM_TARBALL_URL).$(SUM_EXT) -O $(BUILD_DIR)/$(ZRYTHM_TARBALL_SUM)
	#wget $(ZRYTHM_TARBALL_URL).asc -O $(BUILD_DIR)/$(ZRYTHM_TARBALL).asc
	#cd $(BUILD_DIR) && $(CALC_SUM) $(ZRYTHM_TARBALL_SUM)
	#cd $(BUILD_DIR) && gpg --verify $(ZRYTHM_TARBALL).asc $(ZRYTHM_TARBALL)

$(BUILD_DIR)/$(ZRYTHM_PKG_TARBALL): $(BUILD_DIR)/$(ZRYTHM_TARBALL)
	cd $(BUILD_DIR) && tar xf $(ZRYTHM_TARBALL) && \
	mv zrythm-$(ZRYTHM_VERSION) zrythm-$(ZRYTHM_PKG_VERSION) && \
	tar cf $(ZRYTHM_PKG_TARBALL) zrythm-$(ZRYTHM_PKG_VERSION)

# target for fetching the ZPlugins release tarball
$(BUILD_DIR)/$(ZPLUGINS_TARBALL):
	mkdir -p $(BUILD_DIR)
	wget $(ZPLUGINS_TARBALL_URL) -O $@

$(BUILD_DIR)/$(RCEDIT64_EXE):
	mkdir -p $(BUILD_DIR)
	wget $(RCEDIT64_URL) -O $@

$(BUILD_DIR)/$(CARLA_SOURCE_ZIP):
	mkdir -p $(BUILD_DIR)
	cd $(BUILD_DIR) && wget $(CARLA_SOURCE_URL) && \
		mv $(CARLA_VERSION).zip $(CARLA_SOURCE_ZIP)

$(BUILD_DIR)/$(CARLA_WINDOWS_BINARY_64_ZIP):
	mkdir -p $(BUILD_DIR)
	cd $(BUILD_DIR) && wget $(CARLA_WINDOWS_BINARY_64_URL)

$(BUILD_DIR)/$(CARLA_WINDOWS_BINARY_32_ZIP):
	mkdir -p $(BUILD_DIR)
	cd $(BUILD_DIR) && wget $(CARLA_WINDOWS_BINARY_32_URL)

$(BUILD_DIR)/$(MESON_TARBALL):
	mkdir -p $(BUILD_DIR)
	wget https://github.com/mesonbuild/meson/releases/download/$(MESON_VERSION)/$(MESON_TARBALL) -O $@

pkg-filename-%:
	@echo $($*_PKG_FILE)

pkg-trial-filename-%:
	@echo $($*_TRIAL_PKG_FILE)

# call this if cleaning the chroot environment is needed
.PHONY: clean-windows10-chroot
clean-windows10-chroot:
	rm -rf $(WIN_CHROOT_DIR)

# to be called inside the VM
.PHONY: clean-windows-dir
clean-windows-dir:
	rm -rf $(BUILD_WINDOWS_DIR)

.PHONY: clean-tarball
clean-tarball:
	rm -rf $(BUILD_DIR)/$(ZRYTHM_TARBALL)

.PHONY: clean
clean:
	rm -rf $(BUILD_ARCH_DIR)
	rm -rf $(BUILD_FEDORA32_DIR)
