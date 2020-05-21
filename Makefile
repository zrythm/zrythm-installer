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
CARLA_VERSION=c8b2c61037640ca8c1fa277f8da77fcc86745435
CARLA_SOURCE_URL=https://github.com/falkTX/Carla/archive/$(CARLA_VERSION).zip
CARLA_SOURCE_ZIP=Carla-$(CARLA_VERSION).zip
CARLA_WINDOWS_BINARY_64_ZIP=carla-64-$(shell echo $(CARLA_VERSION) | head -c 7).zip
CARLA_WINDOWS_BINARY_32_ZIP=carla-2.1-woe32.zip
CARLA_WINDOWS_BINARY_64_URL=https://www.zrythm.org/downloads/carla/$(CARLA_WINDOWS_BINARY_64_ZIP)
CARLA_WINDOWS_BINARY_32_URL=https://www.zrythm.org/downloads/carla/$(CARLA_WINDOWS_BINARY_32_ZIP)
ARCH_MXE_ROOT=/home/ansible/Documents/git/mxe
ARCH_MXE_64_STATIC_PREFIX=$(ARCH_MXE_ROOT)/usr/x86_64-w64-mingw32.static
ARCH_MXE_64_SHARED_PREFIX=$(ARCH_MXE_ROOT)/usr/x86_64-w64-mingw32.shared
MXE_FLAGS=MXE_TARGETS='x86_64-w64-mingw32.shared' MXE_PLUGIN_DIRS=$(ARCH_MXE_ROOT)/plugins/meson-wrapper -j1 JOBS=6
MXE_ZPLUGINS_CLONE_PATH=/home/ansible/Documents/git/ZPlugins
MXE_GTK3_CLONE_PATH=/home/ansible/Documents/non-git/gtk+-3.24.18
BUILD_DIR=build
BUILD_DEBIAN10_DIR=$(BUILD_DIR)/debian10
MESON_VERSION=0.53.0
MESON_DIR=meson-$(MESON_VERSION)
MESON_TARBALL=$(MESON_DIR).tar.gz
BUILD_ARCH_DIR=$(BUILD_DIR)/archlinux
BUILD_WINDOWS_DIR=$(BUILD_DIR)/windows10
BUILD_OSX_DIR=$(BUILD_DIR)/osx
WINDOWS_CHROOT_BASE=/tmp/chroot-for-zrythm
WIN_CHROOT_DIR=/tmp/zrythm-root
WIN_TRIAL_CHROOT_DIR=/tmp/zrythm-trial-root
# This is the directory to rsync into
MINGW_SRC_DIR=../../msys64/home/alex/zrythm-build
WINDOWS_ZRYTHM_PKG_TAR_XZ=
RPMBUILD_ROOT=/home/ansible/rpmbuild
BUILD_FEDORA32_DIR=$(BUILD_DIR)/fedora32
BUILD_OPENSUSE_TUMBLEWEED_DIR=$(BUILD_DIR)/opensuse-tumbleweed
ARCH_PKG_FILE=zrythm-$(ZRYTHM_PKG_VERSION)-1-x86_64.pkg.tar.xz
ARCH_TRIAL_PKG_FILE=zrythm-trial-$(ZRYTHM_PKG_VERSION)-1-x86_64.pkg.tar.xz
DEBIAN_PKG_FILE=zrythm_$(ZRYTHM_PKG_VERSION)-1_amd64.deb
DEBIAN_TRIAL_PKG_FILE=zrythm-trial_$(ZRYTHM_PKG_VERSION)-1_amd64.deb
FEDORA32_PKG_FILE=zrythm-$(ZRYTHM_PKG_VERSION)-1.fc32.x86_64.rpm
FEDORA32_TRIAL_PKG_FILE=zrythm-trial-$(ZRYTHM_PKG_VERSION)-1.fc32.x86_64.rpm
OPENSUSE_TUMBLEWEED_PKG_FILE=zrythm-$(ZRYTHM_PKG_VERSION)-1.opensuse-tumbleweed.x86_64.rpm
OPENSUSE_TUMBLEWEED_TRIAL_PKG_FILE=zrythm-trial-$(ZRYTHM_PKG_VERSION)-1.opensuse-tumbleweed.x86_64.rpm
WINDOWS_INSTALLER=zrythm-$(ZRYTHM_PKG_VERSION)-setup.exe
WINDOWS_TRIAL_INSTALLER=zrythm-trial-$(ZRYTHM_PKG_VERSION)-setup.exe
WINDOWS_PKG_FILE=$(WINDOWS_INSTALLER)
WINDOWS_TRIAL_PKG_FILE=$(WINDOWS_TRIAL_INSTALLER)
GNU_PLAYBOOK=playbook.yml
WOE_PLAYBOOK=woe-playbook.yml
ANSIBLE_PLAYBOOK_CMD=ansible-playbook -i ./ansible-conf.ini --extra-vars "version=$(ZRYTHM_PKG_VERSION) zplugins_version=$(ZPLUGINS_VERSION) meson_version=$(MESON_VERSION) carla_version=$(CARLA_VERSION)" -v
WINDOWS_IP=192.168.100.178
ARCH_IP=192.168.100.142
ZRYTHM_MINGW_REVISION=2
MINGW_ZRYTHM_PKG_TAR=mingw-w64-zrythm-$(ZRYTHM_PKG_VERSION)-$(ZRYTHM_MINGW_REVISION)-any.pkg.tar.xz
MINGW_ZRYTHM_TRIAL_PKG_TAR=mingw-w64-zrythm-trial-$(ZRYTHM_PKG_VERSION)-$(ZRYTHM_MINGW_REVISION)-any.pkg.tar.xz
MINGW_ZPLUGINS_PKG_TAR=mingw-w64-zplugins-$(ZPLUGINS_VERSION)-1-any.pkg.tar.xz
MINGW_ZPLUGINS_TRIAL_PKG_TAR=mingw-w64-zplugins-trial-$(ZPLUGINS_VERSION)-1-any.pkg.tar.xz
MINGW_ZRYTHM_SRC=/tmp/makepkg/mingw-w64-zrythm/src/zrythm-$(ZRYTHM_PKG_VERSION)
MINGW_ZPLUGINS_SRC=/tmp/makepkg/mingw-w64-zplugins/src/zplugins-$(ZPLUGINS_VERSION)
MINGW_PREFIX=/usr/x86_64-w64-mingw32
RCEDIT64_EXE=rcedit-x64.exe
RCEDIT64_VER=1.1.1
RCEDIT64_URL=https://github.com/electron/rcedit/releases/download/v$(RCEDIT64_VER)/$(RCEDIT64_EXE)
UNIX_INSTALLER_ZIP=zrythm-$(ZRYTHM_PKG_VERSION)-installer.zip
UNIX_TRIAL_INSTALLER_ZIP=zrythm-trial-$(ZRYTHM_PKG_VERSION)-installer.zip
COMMON_SRC_DEPS=$(BUILD_DIR)/$(ZPLUGINS_TARBALL) $(BUILD_DIR)/$(ZRYTHM_PKG_TARBALL) $(BUILD_DIR)/meson/meson.py $(BUILD_DIR)/$(CARLA_SOURCE_ZIP)
OSX_INSTALL_PREFIX=/tmp/zrythm-osx
OSX_INSTALL_TRIAL_PREFIX=/tmp/zrythm-trial-osx
OSX_INSTALLER=zrythm-$(ZRYTHM_PKG_VERSION)-setup.dmg
OSX_PKG_FILE=$(OSX_INSTALLER)
OSX_TRIAL_INSTALLER=zrythm-trial-$(ZRYTHM_PKG_VERSION)-setup.dmg
OSX_TRIAL_PKG_FILE=$(OSX_TRIAL_INSTALLER)
APPIMAGE_APPDIR=/tmp/appimage/AppDir
BREEZE_DARK_PATH=/Users/alex/.local/share/icons/breeze-dark
MANUAL_ZIP_PATH=$(BUILD_DIR)/user-manual.zip

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

# creates an installer-in-x target (UNIX)
# arg 1: VM name
define create_installer_in_x_target
installer-in-$(1): $(UNIX_INSTALLER_ZIP) $(UNIX_TRIAL_INSTALLER_ZIP)
	$$(call start_vm,$(1))
	ansible -i ./ansible-conf.ini -m copy -a "src=$(UNIX_INSTALLER_ZIP) dest=~/" $(1)
	ansible -i ./ansible-conf.ini -m copy -a "src=$(UNIX_TRIAL_INSTALLER_ZIP) dest=~/" $(1)
	$$(call stop_vm,$(1))
endef

# creates the artifacts for unix
# argument 1: the installer zip filename
# argument 2: `-trial` if trial, otherwise empty
# argument 3: dependency (make trial depend on non-trial so
# they are not run in parallel)
define create_installer_zip_target
${1}: unix-artifacts tools/gen_installer.sh README$(2).in installer.sh.in FORCE ${3}
	tools/gen_installer.sh $(ZRYTHM_PKG_VERSION) $(1) $(2) $(ZPLUGINS_VERSION)
endef

# creates a generic artifact target
# arg 1: the VM name
# arg 2: the package filename
# arg 3: the trial package filename
# arg 4: the extra dependencies
#artifacts/$(1)/$(2) artifacts/$(1)/$(3) artifacts/$(1)/ZLFO.lv2/manifest.ttl &: $(COMMON_SRC_DEPS) $(4)
define generic_artifact_target
artifacts/$(1)/zplugins/$(ZLFO_MANIFEST): $(COMMON_SRC_DEPS) $(4)
	$$(call run_build_in_vm,$(1))
endef

# creates the debian artifact targets
# arg 1: the VM name
define debian_artifact_target
$(call generic_artifact_target,$(1),$(DEBIAN_PKG_FILE),$(DEBIAN_TRIAL_PKG_FILE),debian.changelog.in debian.compat debian.control debian.copyright debian.rules)
endef

.PHONY: all
all: installers-in-vms

.PHONY: installers-in-vms
installers-in-vms: installer-in-debian10 installer-in-linuxmint193 installer-in-ubuntu1910 installer-in-ubuntu2004 installer-in-ubuntu1804 installer-in-archlinux installer-in-fedora32

.PHONY: FORCE
FORCE:

# runs everything and produces the installer zip
$(eval $(call create_installer_zip_target,$(UNIX_INSTALLER_ZIP),))
$(eval $(call create_installer_zip_target,$(UNIX_TRIAL_INSTALLER_ZIP),-trial,$(UNIX_INSTALLER_ZIP)))

# installer-in-x targets
#$(eval $(call create_installer_in_x_target,debian9))
$(eval $(call create_installer_in_x_target,debian10))
$(eval $(call create_installer_in_x_target,linuxmint193))
$(eval $(call create_installer_in_x_target,ubuntu1910))
$(eval $(call create_installer_in_x_target,ubuntu2004))
$(eval $(call create_installer_in_x_target,ubuntu1804))
$(eval $(call create_installer_in_x_target,archlinux))
$(eval $(call create_installer_in_x_target,fedora32))
#$(eval $(call create_installer_in_x_target,opensuse-tumbleweed))

# runs the ansible playbook to produce artifacts
# for each distro
# these assume that the trial artifacts and ZLFO
# are also produced since they are group targets
.PHONY: unix-artifacts
unix-artifacts: artifacts/debian10/zplugins/$(ZLFO_MANIFEST) artifacts/linuxmint193/zplugins/$(ZLFO_MANIFEST) artifacts/ubuntu2004/zplugins/$(ZLFO_MANIFEST) artifacts/ubuntu1910/zplugins/$(ZLFO_MANIFEST) artifacts/ubuntu1804/zplugins/$(ZLFO_MANIFEST) artifacts/archlinux/zplugins/$(ZLFO_MANIFEST) artifacts/fedora32/zplugins/$(ZLFO_MANIFEST)

#$(eval $(call debian_artifact_target,debian9))
$(eval $(call debian_artifact_target,debian10))
$(eval $(call debian_artifact_target,linuxmint193))
$(eval $(call debian_artifact_target,ubuntu2004))
$(eval $(call debian_artifact_target,ubuntu1910))
$(eval $(call debian_artifact_target,ubuntu1804))
$(eval $(call generic_artifact_target,archlinux,$(ARCH_PKG_FILE),$(ARCH_TRIAL_PKG_FILE)))
$(eval $(call generic_artifact_target,fedora32,$(FEDORA32_PKG_FILE),$(FEDORA32_TRIAL_PKG_FILE)))
$(eval $(call generic_artifact_target,opensuse-tumbleweed,$(OPENSUSE_TUMBLEWEED_PKG_FILE),$(OPENSUSE_TUMBLEWEED_TRIAL_PKG_FILE)))

artifacts/windows10/$(WINDOWS_INSTALLER) artifacts/windows10/$(WINDOWS_TRIAL_INSTALLER) &: $(COMMON_SRC_DEPS) $(BUILD_DIR)/$(RCEDIT64_EXE)
	$(call run_windows_build_in_vm))

define make_carla
	export PKG_CONFIG_PATH=/usr/lib/zrythm/lib/pkgconfig && \
	if pkg-config --atleast-version=2.1 carla-native-plugin ; then \
		echo "latest carla installed" ; \
	fi
	cd $(BUILD_DIR) && unzip -o $(CARLA_SOURCE_ZIP) && \
		cd Carla-$(CARLA_VERSION) && \
		make -j4 && $(2) make install PREFIX=$(1)/lib/zrythm
endef

define remove_carla
	cd $(BUILD_DIR)/Carla-$(CARLA_VERSION) && \
		sudo make uninstall PREFIX=$(1)/lib/zrythm
endef

# arg 1: prefix
# arg 2: trial version true/false
define make_osx
	cd $(BUILD_OSX_DIR) && tar xf $(ZRYTHM_PKG_TARBALL) && \
		cd zrythm-$(ZRYTHM_PKG_VERSION) && \
		rm -rf build && \
		meson build -Dsdl=enabled -Drtaudio=auto \
		  -Drtmidi=auto -Dffmpeg=enabled \
			-Dmac-release=true -Dtrial-ver=$(2) \
			-Djack=disabled -Dgraphviz=enabled \
			-Dcarla=enabled -Dwith-manpage=false \
			--prefix=$(1) && \
		ninja -C build && ninja -C build install
endef

$(OSX_INSTALL_PREFIX)/bin/zrythm $(OSX_INSTALL_TRIAL_PREFIX)/bin/zrythm&: $(BUILD_DIR)/$(ZRYTHM_PKG_TARBALL) $(BUILD_DIR)/$(CARLA_SOURCE_ZIP)
	-rm -rf $(BUILD_OSX_DIR)/$(ZRYTHM_PKG_TARBALL)
	-rm -rf $(OSX_INSTALL_PREFIX)
	mkdir -p $(BUILD_OSX_DIR)
	cp $(BUILD_DIR)/$(ZRYTHM_PKG_TARBALL) $(BUILD_OSX_DIR)/$(ZRYTHM_PKG_TARBALL)
	$(call make_carla,$(OSX_INSTALL_TRIAL_PREFIX))
	$(call make_osx,$(OSX_INSTALL_TRIAL_PREFIX),true)
	$(call make_carla,$(OSX_INSTALL_PREFIX))
	$(call make_osx,$(OSX_INSTALL_PREFIX),false)

# this must be run on macos
artifacts/osx/$(OSX_INSTALLER) artifacts/osx/$(OSX_TRIAL_INSTALLER)&: tools/gen_osx_installer.sh $(OSX_INSTALL_PREFIX)/bin/zrythm $(OSX_INSTALL_TRIAL_PREFIX)/bin/zrythm tools/osx/launcher.sh tools/osx/appdmg.json.in
	tools/gen_osx_installer.sh $(ZRYTHM_PKG_VERSION) \
		$(BUILD_OSX_DIR)/zrythm-$(ZRYTHM_PKG_VERSION) \
		$(OSX_INSTALL_PREFIX) \
		artifacts/osx/$(OSX_INSTALLER) \
		$$(pwd)/tools/osx /usr/local \
		Zrythm Zrythm $(BREEZE_DARK_PATH)
	tools/gen_osx_installer.sh $(ZRYTHM_PKG_VERSION) \
		$(BUILD_OSX_DIR)/zrythm-$(ZRYTHM_PKG_VERSION) \
		$(OSX_INSTALL_TRIAL_PREFIX) \
		artifacts/osx/$(OSX_TRIAL_INSTALLER) \
		$$(pwd)/tools/osx /usr/local \
		"Zrythm (Trial)" Zrythm-trial $(BREEZE_DARK_PATH)

.PHONY: osx
osx: artifacts/osx/$(OSX_INSTALLER) artifacts/osx/$(OSX_TRIAL_INSTALLER)

#.PHONY: debian9
#debian9: $(BUILD_DIR)/$(DEBIAN_PKG_FILE)

# Debian 10 target to be used by ansible inside the
# debian VM
.PHONY: debian10
debian10: $(BUILD_DIR)/$(DEBIAN_PKG_FILE)

.PHONY: linuxmint193
linuxmint193: $(BUILD_DIR)/$(DEBIAN_PKG_FILE)

# Ubuntu 20.04 target to be used by ansible inside the
# ubuntu VM
.PHONY: ubuntu2004
ubuntu2004: $(BUILD_DIR)/$(DEBIAN_PKG_FILE)

.PHONY: ubuntu1910
ubuntu1910: $(BUILD_DIR)/$(DEBIAN_PKG_FILE)

.PHONY: ubuntu1804
ubuntu1804: $(BUILD_DIR)/$(DEBIAN_PKG_FILE)

define prepare_debian
	rm -rf $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)
	mkdir -p $(BUILD_DEBIAN10_DIR)
	cp $(BUILD_DIR)/$(ZRYTHM_PKG_TARBALL) $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DEBIAN_TARBALL)
	cp $(BUILD_DIR)/$(ZRYTHM_PKG_TARBALL) $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_TRIAL_DEBIAN_TARBALL)
	# rezip because gzip says not valid gzip format
	cd $(BUILD_DEBIAN10_DIR) && tar xf $(ZRYTHM_DEBIAN_TARBALL) && \
		tar cf $(ZRYTHM_DEBIAN_TARBALL_TAR) $(ZRYTHM_DIR) && \
		tar cf $(ZRYTHM_TRIAL_DEBIAN_TARBALL_TAR) $(ZRYTHM_DIR) && \
		rm $(ZRYTHM_DEBIAN_TARBALL) && gzip $(ZRYTHM_DEBIAN_TARBALL_TAR) && \
		rm $(ZRYTHM_TRIAL_DEBIAN_TARBALL) && gzip $(ZRYTHM_TRIAL_DEBIAN_TARBALL_TAR)
	mkdir -p $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/source
	cp debian.changelog.in $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/changelog
	sed -i -e 's/@VERSION@/$(ZRYTHM_PKG_VERSION)/' $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/changelog
	cp debian.compat $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/compat
	cp debian.control $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/control
	cp debian.copyright $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/copyright
	cp debian.rules $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/rules
	if [ "$$(hostname)" = "linuxmint193" ] ; then \
			sed -i -e 's/-Dffmpeg=enabled/-Dffmpeg=disabled/' $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/rules; \
			sed -i -e 's/ninja test/echo test/' $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/rules; \
		fi
	echo "3.0 (quilt)" > $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/source/format
endef

# arg 1: anything
# arg 2: `true` for trial, `false` for normal ver
define make_zplugins
	rm -rf /tmp/$(1)/usr/lib/lv2/Z*.lv2
	rm -rf $(BUILD_DIR)/zplugins-v$(ZPLUGINS_VERSION)
	cd $(BUILD_DIR) && tar xf $(ZPLUGINS_TARBALL)
	cd $(BUILD_DIR)/zplugins-v$(ZPLUGINS_VERSION) && \
		cd ext/Soundpipe && CC=gcc make && cd ../.. && \
		../meson/meson.py build --buildtype=release \
		-Dtrial_ver=$(2) --prefix=/usr && \
		DESTDIR=/tmp ninja -C build install
	cp -R /tmp/$(1)/usr/lib/lv2/Z*.lv2 $(BUILD_DIR)/
	ls -l $(BUILD_DIR)/Z*.lv2
endef

$(BUILD_DIR)/$(DEBIAN_PKG_FILE): debian.changelog.in debian.compat debian.control debian.copyright debian.rules $(COMMON_SRC_DEPS)
	rm -rf $(BUILD_DEBIAN10_DIR)
	$(call make_carla,/usr,sudo)
	# make regular version
	$(call prepare_debian)
	cd $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR) && debuild -us -uc
	# make trial
	$(call prepare_debian)
	sed -i -e '8s/$$/ -Dtrial-ver=true/' $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/rules
	sed -i -e 's|debian/zrythm|debian/zrythm-trial|' $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/rules
	sed -i -e '1s/zrythm/zrythm-trial/' $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/changelog
	sed -i -e 's/: zrythm/: zrythm-trial/g' $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/control
	cd $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR) && debuild -us -uc
	# make plugins
	$(call make_zplugins,,true)
	$(call make_zplugins,,false)
	$(call remove_carla)

$(BUILD_DIR)/$(MESON_TARBALL):
	wget https://github.com/mesonbuild/meson/releases/download/$(MESON_VERSION)/$(MESON_TARBALL) -O $@

.PHONY: archlinux
archlinux: $(BUILD_DIR)/$(ARCH_PKG_FILE)

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
			-Dtrial-ver=$(2) --prefix=/usr && \
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

$(BUILD_DIR)/$(ARCH_PKG_FILE): PKGBUILD.in $(COMMON_SRC_DEPS)
	$(call make_carla,/usr,sudo)
	rm -rf $(BUILD_ARCH_DIR)
	mkdir -p $(BUILD_ARCH_DIR)
	cp PKGBUILD.in $(BUILD_ARCH_DIR)/PKGBUILD
	cp $(BUILD_DIR)/$(ZRYTHM_PKG_TARBALL) $(BUILD_ARCH_DIR)/
	sed -i -e 's/@VERSION@/$(ZRYTHM_PKG_VERSION)/' $(BUILD_ARCH_DIR)/PKGBUILD
	# make normal version
	cd $(BUILD_ARCH_DIR) && makepkg -f
	# make manual
	cd $(BUILD_DIR) && tar xf $(ZRYTHM_PKG_TARBALL) && \
		cd zrythm-$(ZRYTHM_PKG_VERSION) && \
		meson build && \
		sed -i -e 's/latexpdf/latex/' doc/user/meson.build && \
		ninja -C build latex-manual-en latex-manual-fr latex-manual-de && \
		make -C build/doc/user/en/latex && \
		make -C build/doc/user/fr/latex && \
		make -C build/doc/user/de/latex
	# make trial
	sed -i -e '2s/zrythm/zrythm-trial/' $(BUILD_ARCH_DIR)/PKGBUILD
	sed -i -e 's/-Dtrial-ver=false/-Dtrial-ver=true/' $(BUILD_ARCH_DIR)/PKGBUILD
	cd $(BUILD_ARCH_DIR) && makepkg -f
	# make plugins
	$(call make_zplugins,,true)
	$(call make_zplugins,,false)
	# make appimage
	$(call remove_carla)

.PHONY: windows10
windows10: $(BUILD_DIR)/$(WINDOWS_TRIAL_INSTALLER) $(BUILD_DIR)/$(WINDOWS_INSTALLER)

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
		sed -i -e 's/-Dtrial-ver=false/-Dtrial-ver=$(2)/' src/zrythm.mk && \
		sed -i -e 's/-Dtrial-ver=true/-Dtrial-ver=$(2)/' src/zrythm.mk && \
		sed -i -e 's/_VERSION  .*/_VERSION  := $(ZRYTHM_VERSION)/' src/zrythm.mk && \
		./bootstrap && \
		make update-checksum-zrythm && \
		make $(MXE_FLAGS) zrythm
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
		plugins$(4) $(4) $(BREEZE_DARK_PATH) \
		$(MANUAL_ZIP_PATH)
	cp "$(BUILD_WINDOWS_DIR)/installer/dist/Output/$(3) $(ZRYTHM_PKG_VERSION).exe" $(BUILD_DIR)/$(2)
endef

$(eval $(call make_windows_installer_target,,$(WINDOWS_INSTALLER),Zrythm))
$(eval $(call make_windows_installer_target,,$(WINDOWS_TRIAL_INSTALLER),Zrythm Trial,-trial))

.PHONY: fedora32
fedora32: $(BUILD_DIR)/$(FEDORA32_PKG_FILE)

#.PHONY: opensuse-tumbleweed
#opensuse-tumbleweed: $(BUILD_DIR)/$(OPENSUSE_TUMBLEWEED_PKG_FILE)

# create RPM target
# arg 1: pkg filename
# arg 2: build dir
define make_rpm_target
$(BUILD_DIR)/$(1): zrythm.spec.in $(COMMON_SRC_DEPS)
	$$(call make_carla,/usr,sudo)
	rm -rf $(2)
	rm -rf $(RPMBUILD_ROOT)/BUILDROOT/*
	mkdir -p $(RPMBUILD_ROOT) && \
		cd $(RPMBUILD_ROOT) && \
		mkdir -p BUILD BUILDROOT RPMS SOURCES SPECS SRPMS
	mkdir -p $(2)
	cp zrythm.spec.in $(RPMBUILD_ROOT)/SPECS/zrythm.spec
	sed -i -e 's/@VERSION@/$(ZRYTHM_PKG_VERSION)/' $(RPMBUILD_ROOT)/SPECS/zrythm.spec
	cp $(BUILD_DIR)/$(ZRYTHM_PKG_TARBALL) \
		$(RPMBUILD_ROOT)/SOURCES/
	# make normal version
	rpmbuild -ba $(RPMBUILD_ROOT)/SPECS/zrythm.spec
	# make trial
	sed -i -e '9s/zrythm/zrythm-trial/' $(RPMBUILD_ROOT)/SPECS/zrythm.spec
	sed -i -e 's/-Dtrial-ver=false/-Dtrial-ver=true/' $(RPMBUILD_ROOT)/SPECS/zrythm.spec
	rpmbuild -ba $(RPMBUILD_ROOT)/SPECS/zrythm.spec
	# make plugins
	$$(call make_zplugins,,true)
	$$(call make_zplugins,,false)
	$$(call remove_carla)
endef

$(eval $(call make_rpm_target,$(FEDORA32_PKG_FILE),$(BUILD_FEDORA32_DIR)))
$(eval $(call make_rpm_target,$(OPENSUSE_TUMBLEWEED_PKG_FILE),$(BUILD_OPENSUSE_TUMBLEWEED_DIR)))

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
	wget $(RCEDIT64_URL) -O $@

$(BUILD_DIR)/$(CARLA_SOURCE_ZIP):
	cd $(BUILD_DIR) && wget $(CARLA_SOURCE_URL) && \
		mv $(CARLA_VERSION).zip $(CARLA_SOURCE_ZIP)

$(BUILD_DIR)/$(CARLA_WINDOWS_BINARY_64_ZIP):
	cd $(BUILD_DIR) && wget $(CARLA_WINDOWS_BINARY_64_URL)

$(BUILD_DIR)/$(CARLA_WINDOWS_BINARY_32_ZIP):
	cd $(BUILD_DIR) && wget $(CARLA_WINDOWS_BINARY_32_URL)

pkg-filename-%:
	@echo $($*_PKG_FILE)

pkg-trial-filename-%:
	@echo $($*_PKG_TRIAL_FILE)

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
	rm -rf $(BUILD_DEBIAN10_DIR)
	rm -rf $(BUILD_ARCH_DIR)
	rm -rf $(BUILD_FEDORA32_DIR)
