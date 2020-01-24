ZRYTHM_VERSION=0.7.425
ZRYTHM_TARBALL=zrythm-$(ZRYTHM_VERSION).tar.xz
ZRYTHM_DIR=zrythm-$(ZRYTHM_VERSION)
ZRYTHM_DEBIAN_TARBALL=zrythm_$(ZRYTHM_VERSION).orig.tar.xz
SUM_EXT=sha256sum
ZRYTHM_TARBALL_SUM=zrythm-$(ZRYTHM_VERSION).tar.xz.$(SUM_EXT)
CALC_SUM=sha256sum --check
ZRYTHM_TARBALL_URL=https://www.zrythm.org/releases/$(ZRYTHM_TARBALL)
BUILD_DIR=build
BUILD_DEBIAN10_DIR=$(BUILD_DIR)/debian10
MESON_VERSION=0.53.0
MESON_DIR=meson-$(MESON_VERSION)
MESON_TARBALL=$(MESON_DIR).tar.gz
BUILD_ARCH_DIR=$(BUILD_DIR)/arch
BUILD_WINDOWS_DIR=$(BUILD_DIR)/windows10
WIN_CHROOT_DIR=/tmp/zrythm-root
# This is the directory to rsync into
MINGW_SRC_DIR=../../msys64/home/alex/zrythm-build
WINDOWS_ZRYTHM_PKG_TAR_XZ=
RPMBUILD_ROOT=/home/ansible/rpmbuild
BUILD_FEDORA31_DIR=$(BUILD_DIR)/fedora31
BUILD_OPENSUSE_TUMBLEWEED_DIR=$(BUILD_DIR)/opensuse-tumbleweed
ARCH_PKG_FILE=zrythm-$(ZRYTHM_VERSION)-1-x86_64.pkg.tar.xz
DEBIAN_PKG_FILE=zrythm_$(ZRYTHM_VERSION)-1_amd64.deb
FEDORA31_PKG_FILE=zrythm-$(ZRYTHM_VERSION)-1.fc31.x86_64.rpm
OPENSUSE_TUMBLEWEED_PKG_FILE=zrythm-$(ZRYTHM_VERSION)-1.opensuse-tumbleweed.x86_64.rpm
WINDOWS_INSTALLER=zrythm-$(ZRYTHM_VERSION)-setup.exe
ANSIBLE_PLAYBOOK_CMD=ansible-playbook -i ./ansible-conf.ini playbook.yml --extra-vars "version=$(ZRYTHM_VERSION)" -v
WINDOWS_IP=192.168.100.178
MINGW_ZRYTHM_PKG_TAR=mingw-w64-x86_64-zrythm-$(ZRYTHM_VERSION)-2-any.pkg.tar.zst
RCEDIT64_EXE=rcedit-x64.exe
RCEDIT64_VER=1.1.1
RCEDIT64_URL=https://github.com/electron/rcedit/releases/download/v$(RCEDIT64_VER)/$(RCEDIT64_EXE)

define start_vm
	if sudo virsh list | grep -q " $(1) .*paused" ; then \
	sudo virsh resume $(1); \
	elif ! sudo virsh list | grep -q "$(1)" ; then \
		sudo virsh start $(1); \
		sleep 18; \
	fi
endef

define stop_vm
	sudo virsh shutdown $(1)
endef

define run_build_in_vm
	$(call start_vm,$(1))
	$(ANSIBLE_PLAYBOOK_CMD) -l $(1)
	$(call stop_vm,$(1))
endef

# copy the installer to the vm for testing
define copy_installer_to_vm
	$(call start_vm,$(1))
	ansible -i ./ansible-conf.ini -m copy -a "src=zrythm_installer.zip dest=~/" $(1)
	$(call stop_vm,$(1))
endef

# pushes the installer in each vm after it's made
.PHONY: installer-in-vms
installer-in-vms: installer-in-debian9 installer-in-debian10 installer-in-linuxmint193 installer-in-ubuntu1904 installer-in-ubuntu1804 installer-in-archlinux installer-in-fedora31 installer-in-opensuse-tumbleweed

installer-in-debian9: zrythm_installer.zip
	$(call copy_installer_to_vm,debian9)

installer-in-debian10: zrythm_installer.zip
	$(call copy_installer_to_vm,debian10)

installer-in-linuxmint193: zrythm_installer.zip
	$(call copy_installer_to_vm,linuxmint193)

installer-in-ubuntu1904: zrythm_installer.zip
	$(call copy_installer_to_vm,ubuntu1904)

installer-in-ubuntu1804: zrythm_installer.zip
	$(call copy_installer_to_vm,ubuntu1804)

installer-in-archlinux: zrythm_installer.zip
	$(call copy_installer_to_vm,archlinux)

installer-in-fedora31: zrythm_installer.zip
	$(call copy_installer_to_vm,fedora31)

installer-in-opensuse-tumbleweed: zrythm_installer.zip
	$(call copy_installer_to_vm,opensuse-tumbleweed)

.PHONY: FORCE
FORCE:

# runs everything and produces the installer zip
zrythm_installer.zip: artifacts tools/gen_installer.sh README.in installer.sh.in FORCE
	rm -rf bin.bak
	- mv bin bin.bak
	mkdir -p bin/debian
	mkdir -p bin/ubuntu
	mkdir -p bin/linuxmint
	mkdir -p bin/arch
	mkdir -p bin/fedora
	mkdir -p bin/opensuse
	cp artifacts/debian9/$(DEBIAN_PKG_FILE) \
		bin/debian/zrythm-$(ZRYTHM_VERSION)-1_9_amd64.deb
	cp artifacts/debian10/$(DEBIAN_PKG_FILE) \
		bin/debian/zrythm-$(ZRYTHM_VERSION)-1_10_amd64.deb
	cp artifacts/linuxmint193/$(DEBIAN_PKG_FILE) \
		bin/linuxmint/zrythm-$(ZRYTHM_VERSION)-1_19.3_amd64.deb
	cp artifacts/ubuntu1904/$(DEBIAN_PKG_FILE) \
		bin/ubuntu/zrythm-$(ZRYTHM_VERSION)-1_19.04_amd64.deb
	cp artifacts/ubuntu1804/$(DEBIAN_PKG_FILE) \
		bin/ubuntu/zrythm-$(ZRYTHM_VERSION)-1_18.04_amd64.deb
	cp artifacts/arch/$(ARCH_PKG_FILE) \
		bin/arch/zrythm-$(ZRYTHM_VERSION)-1_x86_64.pkg.tar.xz
	cp artifacts/fedora31/$(FEDORA31_PKG_FILE) \
		bin/fedora/zrythm-$(ZRYTHM_VERSION)-1_31_x86_64.rpm
	cp artifacts/opensuse-tumbleweed/$(OPENSUSE_TUMBLEWEED_PKG_FILE) \
		bin/opensuse/zrythm-$(ZRYTHM_VERSION)-1_tumbleweed_x86_64.rpm
	sed 's/@VERSION@/$(ZRYTHM_VERSION)/' < README.in > README
	sed 's/@VERSION@/$(ZRYTHM_VERSION)/' < installer.sh.in > installer.sh
	chmod +x installer.sh
	tools/gen_installer.sh $(ZRYTHM_VERSION)
	rm README installer.sh

# runs the ansible playbook to produce artifacts
# for each distro
.PHONY: artifacts
artifacts: artifacts/debian9/$(DEBIAN_PKG_FILE) artifacts/debian10/$(DEBIAN_PKG_FILE) artifacts/linuxmint193/$(DEBIAN_PKG_FILE) artifacts/ubuntu1904/$(DEBIAN_PKG_FILE) artifacts/ubuntu1804/$(DEBIAN_PKG_FILE) artifacts/arch/$(ARCH_PKG_FILE) artifacts/fedora31/$(FEDORA31_PKG_FILE) artifacts/opensuse-tumbleweed/$(OPENSUSE_TUMBLEWEED_PKG_FILE)

artifacts/debian9/$(DEBIAN_PKG_FILE): debian.changelog.in debian.compat debian.control debian.copyright debian.rules $(BUILD_DIR)/$(ZRYTHM_TARBALL) $(BUILD_DIR)/meson/meson.py
	$(call run_build_in_vm,debian9)

artifacts/debian10/$(DEBIAN_PKG_FILE): debian.changelog.in debian.compat debian.control debian.copyright debian.rules $(BUILD_DIR)/$(ZRYTHM_TARBALL) $(BUILD_DIR)/meson/meson.py
	$(call run_build_in_vm,debian10)

artifacts/linuxmint193/$(DEBIAN_PKG_FILE): debian.changelog.in debian.compat debian.control debian.copyright debian.rules $(BUILD_DIR)/$(ZRYTHM_TARBALL) $(BUILD_DIR)/meson/meson.py
	$(call run_build_in_vm,linuxmint193)

artifacts/ubuntu1904/$(DEBIAN_PKG_FILE): debian.changelog.in debian.compat debian.control debian.copyright debian.rules $(BUILD_DIR)/$(ZRYTHM_TARBALL) $(BUILD_DIR)/meson/meson.py
	$(call run_build_in_vm,ubuntu1904)

artifacts/ubuntu1804/$(DEBIAN_PKG_FILE): debian.changelog.in debian.compat debian.control debian.copyright debian.rules $(BUILD_DIR)/$(ZRYTHM_TARBALL) $(BUILD_DIR)/meson/meson.py
	$(call run_build_in_vm,ubuntu1804)

artifacts/arch/$(ARCH_PKG_FILE): PKGBUILD.in $(BUILD_DIR)/$(ZRYTHM_TARBALL)
	$(call run_build_in_vm,archlinux)

artifacts/fedora31/$(FEDORA31_PKG_FILE): zrythm.spec.in $(BUILD_DIR)/$(ZRYTHM_TARBALL) $(BUILD_DIR)/meson/meson.py
	$(call run_build_in_vm,fedora31)

artifacts/opensuse-tumbleweed/$(OPENSUSE_TUMBLEWEED_PKG_FILE): zrythm.spec.in $(BUILD_DIR)/$(ZRYTHM_TARBALL) $(BUILD_DIR)/meson/meson.py
	$(call run_build_in_vm,opensuse-tumbleweed)

artifacts/windows10/$(WINDOWS_INSTALLER): PKGBUILD-w10.in $(BUILD_DIR)/$(ZRYTHM_TARBALL) $(BUILD_DIR)/$(RCEDIT64_EXE)
	$(call start_vm,windows10)
	echo "Make sure that the default openssh shell is bash.exe"
	echo "Copying files, enter password (alex) to continue"
	rsync -r ./* alex@$(WINDOWS_IP):$(MINGW_SRC_DIR)/
	echo "Go into the VM and run make windows10 in the zrythm-build directory. When the installer is built, press y to continue" && \
		read -d "y"
	scp alex@$(WINDOWS_IP):$(MINGW_SRC_DIR)/build/$(WINDOWS_INSTALLER) artifacts/windows10/$(WINDOWS_INSTALLER)
	#cp $(BUILD_DIR)/$(WINDOWS_INSTALLER) artifacts/windows10/$(WINDOWS_INSTALLER)
	$(call stop_vm,windows10)

.PHONY: debian9
debian9: $(BUILD_DIR)/$(DEBIAN_PKG_FILE)

# Debian 10 target to be used by ansible inside the
# debian VM
.PHONY: debian10
debian10: $(BUILD_DIR)/$(DEBIAN_PKG_FILE)

.PHONY: linuxmint193
linuxmint193: $(BUILD_DIR)/$(DEBIAN_PKG_FILE)

# Ubuntu 19.04 target to be used by ansible inside the
# ubuntu VM
.PHONY: ubuntu1904
ubuntu1904: $(BUILD_DIR)/$(DEBIAN_PKG_FILE)

.PHONY: ubuntu1804
ubuntu1804: $(BUILD_DIR)/$(DEBIAN_PKG_FILE)

$(BUILD_DIR)/$(DEBIAN_PKG_FILE): debian.changelog.in debian.compat debian.control debian.copyright debian.rules $(BUILD_DIR)/$(ZRYTHM_TARBALL) $(BUILD_DIR)/meson/meson.py
	rm -rf $(BUILD_DEBIAN10_DIR)
	mkdir -p $(BUILD_DEBIAN10_DIR)
	cp $(BUILD_DIR)/$(ZRYTHM_TARBALL) $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DEBIAN_TARBALL)
	cd $(BUILD_DEBIAN10_DIR) && tar xf $(ZRYTHM_DEBIAN_TARBALL)
	mkdir -p $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/source
	cp debian.changelog.in $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/changelog
	sed -i -e 's/@VERSION@/$(ZRYTHM_VERSION)/' $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/changelog
	cp debian.compat $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/compat
	cp debian.control $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/control
	cp debian.copyright $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/copyright
	cp debian.rules $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/rules
	if [ "$$(hostname)" = "debian9" ] || [ "$$(hostname)" = "linuxmint193" ] ; then \
			sed -i -e 's/-Denable_ffmpeg=true/-Denable_ffmpeg=false/' $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/rules; \
			sed -i -e 's/ninja test/echo test/' $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/rules; \
		fi
	if [ "$$(hostname)" = "debian9" ]; then \
			sed -i -e 's/fonts-dseg, //' $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/control; \
			sed -i -e 's/-Dinstall_dseg_font=false/-Dinstall_dseg_font=true/' $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/rules; \
		fi
	echo "3.0 (quilt)" > $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/source/format
	cd $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR) && debuild -us -uc

$(BUILD_DIR)/$(MESON_TARBALL):
	wget https://github.com/mesonbuild/meson/releases/download/$(MESON_VERSION)/$(MESON_TARBALL) -O $@

.PHONY: arch
arch: $(BUILD_DIR)/$(ARCH_PKG_FILE)

$(BUILD_DIR)/$(ARCH_PKG_FILE): PKGBUILD.in
	rm -rf $(BUILD_ARCH_DIR)
	mkdir -p $(BUILD_ARCH_DIR)
	cp PKGBUILD.in $(BUILD_ARCH_DIR)/PKGBUILD
	cp $(BUILD_DIR)/$(ZRYTHM_TARBALL) $(BUILD_ARCH_DIR)/
	sed -i -e 's/@VERSION@/$(ZRYTHM_VERSION)/' $(BUILD_ARCH_DIR)/PKGBUILD
	cd $(BUILD_ARCH_DIR) && makepkg -f

.PHONY: windows10
windows10: $(BUILD_DIR)/$(WINDOWS_INSTALLER)

$(BUILD_WINDOWS_DIR)/$(MINGW_ZRYTHM_PKG_TAR): PKGBUILD-w10.in
	rm -rf $(BUILD_WINDOWS_DIR)
	mkdir -p $(BUILD_WINDOWS_DIR)/src
	cp PKGBUILD-w10.in $(BUILD_WINDOWS_DIR)/PKGBUILD
	cp $(BUILD_DIR)/$(ZRYTHM_TARBALL) $(BUILD_WINDOWS_DIR)/
	sed -i -e 's/@VERSION@/$(ZRYTHM_VERSION)/' $(BUILD_WINDOWS_DIR)/PKGBUILD
	cd $(BUILD_WINDOWS_DIR) && makepkg-mingw -f

$(WIN_CHROOT_DIR)/mingw64/bin/zrythm.exe: $(BUILD_WINDOWS_DIR)/$(MINGW_ZRYTHM_PKG_TAR)
	# create chroot
	mkdir -p $(WIN_CHROOT_DIR)
	mkdir -p $(WIN_CHROOT_DIR)/var/lib/pacman
	mkdir -p $(WIN_CHROOT_DIR)/var/log
	mkdir -p $(WIN_CHROOT_DIR)/tmp
	pacman -Syu --root $(WIN_CHROOT_DIR)
	pacman -S filesystem bash pacman --noconfirm --needed --root $(WIN_CHROOT_DIR)
	# install package in chroot
	pacman -U $(BUILD_WINDOWS_DIR)/$(MINGW_ZRYTHM_PKG_TAR) --noconfirm --needed --root $(WIN_CHROOT_DIR)
	ls $(WIN_CHROOT_DIR)/mingw64/bin/zrythm.exe
	# compile glib schemas
	glib-compile-schemas.exe $(WIN_CHROOT_DIR)/mingw64/share/glib-2.0/schemas

$(BUILD_DIR)/$(WINDOWS_INSTALLER): $(WIN_CHROOT_DIR)/mingw64/bin/zrythm.exe FORCE
	# create sources distribution
	-rm $(BUILD_WINDOWS_DIR)/installer/dist/THIRDPARTY_INFO
	mkdir -p $(BUILD_WINDOWS_DIR)/installer/dist
	pacman -Si $(shell pacman -Q --root $(WIN_CHROOT_DIR) | grep mingw | grep -v zrythm | cut -d" " -f1) > $(BUILD_WINDOWS_DIR)/installer/dist/THIRDPARTY_INFO
	# copy other files
	cp $(BUILD_WINDOWS_DIR)/src/zrythm-$(ZRYTHM_VERSION)/AUTHORS $(BUILD_WINDOWS_DIR)/installer/dist/
	cp $(BUILD_WINDOWS_DIR)/src/zrythm-$(ZRYTHM_VERSION)/COPYING* $(BUILD_WINDOWS_DIR)/installer/dist/
	cp $(BUILD_WINDOWS_DIR)/src/zrythm-$(ZRYTHM_VERSION)/README.md $(BUILD_WINDOWS_DIR)/installer/dist/
	cp $(BUILD_WINDOWS_DIR)/src/zrythm-$(ZRYTHM_VERSION)/CONTRIBUTING.md $(BUILD_WINDOWS_DIR)/installer/dist/
	cp $(BUILD_WINDOWS_DIR)/src/zrythm-$(ZRYTHM_VERSION)/THANKS $(BUILD_WINDOWS_DIR)/installer/dist/
	cp $(BUILD_WINDOWS_DIR)/src/zrythm-$(ZRYTHM_VERSION)/TRANSLATORS $(BUILD_WINDOWS_DIR)/installer/dist/
	cp $(BUILD_WINDOWS_DIR)/src/zrythm-$(ZRYTHM_VERSION)/CHANGELOG.md $(BUILD_WINDOWS_DIR)/installer/dist/
	cp $(BUILD_WINDOWS_DIR)/src/zrythm-$(ZRYTHM_VERSION)/data/windows/zrythm.ico $(BUILD_WINDOWS_DIR)/installer/dist/zrythm.ico
	cp $(BUILD_DIR)/$(RCEDIT64_EXE) $(BUILD_WINDOWS_DIR)/installer/
	# create installer
	tools/gen_windows_installer.sh $(WIN_CHROOT_DIR)/mingw64 $(ZRYTHM_VERSION) $(BUILD_WINDOWS_DIR)/installer $(shell pwd)/tools/nsis
	cp $(BUILD_WINDOWS_DIR)/installer/dist/Install_v$(ZRYTHM_VERSION).exe $(BUILD_DIR)/$(WINDOWS_INSTALLER)

.PHONY: fedora31
fedora31: $(BUILD_DIR)/$(FEDORA31_PKG_FILE)

$(BUILD_DIR)/$(FEDORA31_PKG_FILE): zrythm.spec.in $(BUILD_DIR)/$(ZRYTHM_TARBALL)
	rm -rf $(BUILD_FEDORA31_DIR)
	rm -rf $(RPMBUILD_ROOT)/BUILDROOT/*
	mkdir -p $(BUILD_FEDORA31_DIR)
	cp zrythm.spec.in $(RPMBUILD_ROOT)/SPECS/zrythm.spec
	sed -i -e 's/@VERSION@/$(ZRYTHM_VERSION)/' $(RPMBUILD_ROOT)/SPECS/zrythm.spec
	cp $(BUILD_DIR)/$(ZRYTHM_TARBALL) \
		$(RPMBUILD_ROOT)/SOURCES/
	rpmbuild -ba $(RPMBUILD_ROOT)/SPECS/zrythm.spec

.PHONY: opensuse-tumbleweed
opensuse-tumbleweed: $(BUILD_DIR)/$(OPENSUSE_TUMBLEWEED_PKG_FILE)

$(BUILD_DIR)/$(OPENSUSE_TUMBLEWEED_PKG_FILE): zrythm.spec.in $(BUILD_DIR)/$(ZRYTHM_TARBALL)
	rm -rf $(BUILD_OPENSUSE_TUMBLEWEED_DIR)
	rm -rf $(RPMBUILD_ROOT)/BUILDROOT/*
	mkdir -p $(BUILD_OPENSUSE_TUMBLEWEED_DIR)
	cp zrythm.spec.in $(RPMBUILD_ROOT)/SPECS/zrythm.spec
	sed -i -e 's/@VERSION@/$(ZRYTHM_VERSION)/' $(RPMBUILD_ROOT)/SPECS/zrythm.spec
	cp $(BUILD_DIR)/$(ZRYTHM_TARBALL) \
		$(RPMBUILD_ROOT)/SOURCES/
	rpmbuild -ba $(RPMBUILD_ROOT)/SPECS/zrythm.spec

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
	wget $(ZRYTHM_TARBALL_URL).$(SUM_EXT) -O $(BUILD_DIR)/$(ZRYTHM_TARBALL_SUM)
	wget $(ZRYTHM_TARBALL_URL).asc -O $(BUILD_DIR)/$(ZRYTHM_TARBALL).asc
	cd $(BUILD_DIR) && $(CALC_SUM) $(ZRYTHM_TARBALL_SUM)
	cd $(BUILD_DIR) && gpg --verify $(ZRYTHM_TARBALL).asc $(ZRYTHM_TARBALL)

$(BUILD_DIR)/$(RCEDIT64_EXE):
	wget $(RCEDIT64_URL) -O $@

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
	rm -rf $(BUILD_FEDORA31_DIR)
