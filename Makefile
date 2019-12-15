ZRYTHM_VERSION=0.7.186
ZRYTHM_TARBALL=zrythm-$(ZRYTHM_VERSION).tar.xz
ZRYTHM_DIR=zrythm-$(ZRYTHM_VERSION)
ZRYTHM_DEBIAN_TARBALL=zrythm_$(ZRYTHM_VERSION).orig.tar.xz
SUM_EXT=sha256sum
ZRYTHM_TARBALL_SUM=zrythm-$(ZRYTHM_VERSION).tar.xz.$(SUM_EXT)
CALC_SUM=sha256sum --check
ZRYTHM_TARBALL_URL=https://www.zrythm.org/releases/$(ZRYTHM_TARBALL)
BUILD_DIR=build
BUILD_DEBIAN10_DIR=$(BUILD_DIR)/debian10
MESON_DIR=meson-0.52.1
MESON_TARBALL=$(MESON_DIR).tar.gz
BUILD_ARCH_DIR=$(BUILD_DIR)/arch
RPMBUILD_ROOT=/home/ansible/rpmbuild
BUILD_FEDORA31_DIR=$(BUILD_DIR)/fedora31
ARCH_PKG_FILE=zrythm-$(ZRYTHM_VERSION)-1-x86_64.pkg.tar.xz
DEBIAN_PKG_FILE=zrythm_$(ZRYTHM_VERSION)-1_amd64.deb
FEDORA31_PKG_FILE=zrythm-$(ZRYTHM_VERSION)-1.fc31.x86_64.rpm
ANSIBLE_PLAYBOOK_CMD=ansible-playbook -i ./ansible-conf.ini playbook.yml --extra-vars "version=$(ZRYTHM_VERSION)"

define start_vm
	if sudo virsh list | grep -q " $(1) .*paused" ; then \
	sudo virsh resume $(1); \
	elif ! sudo virsh list | grep -q "$(1)" ; then \
		sudo virsh start $(1); \
		sleep 14; \
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

# runs everything and produces the installer zip
.PHONY: installer
installer: artifacts tools/gen_installer.sh README.in installer.sh.in
	rm -rf bin.bak
	mv bin bin.bak
	mkdir -p bin/debian
	mkdir -p bin/ubuntu
	mkdir -p bin/arch
	mkdir -p bin/fedora
	cp artifacts/debian10/$(DEBIAN_PKG_FILE) \
		bin/debian/zrythm-$(ZRYTHM_VERSION)-1_10_amd64.deb
	cp artifacts/ubuntu1810/$(DEBIAN_PKG_FILE) \
		bin/ubuntu/zrythm-$(ZRYTHM_VERSION)-1_18.10_amd64.deb
	cp artifacts/ubuntu1904/$(DEBIAN_PKG_FILE) \
		bin/ubuntu/zrythm-$(ZRYTHM_VERSION)-1_19.04_amd64.deb
	cp artifacts/ubuntu1910/$(DEBIAN_PKG_FILE) \
		bin/ubuntu/zrythm-$(ZRYTHM_VERSION)-1_19.10_amd64.deb
	cp artifacts/arch/$(ARCH_PKG_FILE) \
		bin/arch/zrythm-$(ZRYTHM_VERSION)-1_x86_64.pkg.tar.xz
	cp artifacts/fedora31/$(FEDORA31_PKG_FILE) \
		bin/fedora/zrythm-$(ZRYTHM_VERSION)-1_31_x86_64.rpm
	sed 's/@VERSION@/$(ZRYTHM_VERSION)/' < README.in > README
	sed 's/@VERSION@/$(ZRYTHM_VERSION)/' < installer.sh.in > installer.sh
	chmod +x installer.sh
	tools/gen_installer.sh $(ZRYTHM_VERSION)
	rm README installer.sh
	$(call copy_installer_to_vm,debian10)
	$(call copy_installer_to_vm,ubuntu1810)
	$(call copy_installer_to_vm,ubuntu1904)
	$(call copy_installer_to_vm,ubuntu1910)
	$(call copy_installer_to_vm,manjaro-kde)
	$(call copy_installer_to_vm,fedora31)

# runs the ansible playbook to produce artifacts
# for each distro
.PHONY: artifacts
artifacts: artifacts/debian10/$(DEBIAN_PKG_FILE) artifacts/ubuntu1810/$(DEBIAN_PKG_FILE) artifacts/ubuntu1904/$(DEBIAN_PKG_FILE) artifacts/ubuntu1910/$(DEBIAN_PKG_FILE) artifacts/arch/$(ARCH_PKG_FILE) artifacts/fedora31/$(FEDORA31_PKG_FILE)

artifacts/debian10/$(DEBIAN_PKG_FILE):
	$(call run_build_in_vm,debian10)

artifacts/ubuntu1810/$(DEBIAN_PKG_FILE):
	$(call run_build_in_vm,ubuntu1810)

artifacts/ubuntu1904/$(DEBIAN_PKG_FILE):
	$(call run_build_in_vm,ubuntu1904)

artifacts/ubuntu1910/$(DEBIAN_PKG_FILE):
	$(call run_build_in_vm,ubuntu1910)

artifacts/arch/$(ARCH_PKG_FILE):
	$(call run_build_in_vm,manjaro-kde)

artifacts/fedora31/$(FEDORA31_PKG_FILE):
	$(call run_build_in_vm,fedora31)

# Debian 10 target to be used by ansible inside the
# debian VM
.PHONY: debian10
debian10: $(BUILD_DIR)/$(DEBIAN_PKG_FILE)

.PHONY: ubuntu1810
ubuntu1810: $(BUILD_DIR)/$(DEBIAN_PKG_FILE)

# Ubuntu 19.04 target to be used by ansible inside the
# ubuntu VM
.PHONY: ubuntu1904
ubuntu1904: $(BUILD_DIR)/$(DEBIAN_PKG_FILE)

.PHONY: ubuntu1910
ubuntu1910: $(BUILD_DIR)/$(DEBIAN_PKG_FILE)

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
	echo "3.0 (quilt)" > $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/source/format
	cd $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR) && debuild -us -uc

$(BUILD_DIR)/$(MESON_TARBALL):
	wget https://github.com/mesonbuild/meson/releases/download/0.52.1/$(MESON_TARBALL) -O $@

.PHONY: arch
arch: $(BUILD_DIR)/$(ARCH_PKG_FILE)

$(BUILD_DIR)/$(ARCH_PKG_FILE): PKGBUILD.in
	rm -rf $(BUILD_ARCH_DIR)
	mkdir -p $(BUILD_ARCH_DIR)
	cp PKGBUILD.in $(BUILD_ARCH_DIR)/PKGBUILD
	sed -i -e 's/@VERSION@/$(ZRYTHM_VERSION)/' $(BUILD_ARCH_DIR)/PKGBUILD
	cd $(BUILD_ARCH_DIR) && makepkg -f

.PHONY: fedora31
fedora31: $(BUILD_DIR)/$(FEDORA31_PKG_FILE)
$(BUILD_DIR)/$(FEDORA31_PKG_FILE): zrythm.spec.in
	rm -rf $(BUILD_FEDORA31_DIR)
	rm -rf $(RPMBUILD_ROOT)/BUILDROOT/*
	mkdir -p $(BUILD_FEDORA31_DIR)
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
	cd $(BUILD_DIR) && $(CALC_SUM) $(ZRYTHM_TARBALL_SUM)

.PHONY: clean
clean:
	rm -rf $(BUILD_DEBIAN10_DIR)
	rm -rf $(BUILD_ARCH_DIR)
	rm -rf $(BUILD_FEDORA31_DIR)
