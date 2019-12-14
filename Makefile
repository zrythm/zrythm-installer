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

# runs everything and produces the installer zip
.PHONY: installer
installer: artifacts
	mv bin bin.bak
	mkdir -p bin/debian
	mkdir -p bin/ubuntu
	cp artifacts/debian10/zrythm_$(ZRYTHM_VERSION)-1_amd64.deb \
		bin/debian/zrythm-$(ZRYTHM_VERSION)-1_10_amd64.deb
	cp artifacts/ubuntu1904/zrythm_$(ZRYTHM_VERSION)-1_amd64.deb \
		bin/ubuntu/zrythm-$(ZRYTHM_VERSION)-1_19.04_amd64.deb
	tools/gen_installer.sh $(ZRYTHM_VERSION)

# runs the ansible playbook to produce artifacts
# for each distro
.PHONY: artifacts
artifacts:
	ansible-playbook -i ./ansible-conf.ini playbook.yml --extra-vars "version=$(ZRYTHM_VERSION)"

.PHONY: clean
clean:
	rm -rf $(BUILD_DEBIAN10_DIR)

# Debian 10 target to be used by ansible inside the
# debian VM
.PHONY: debian10
debian10: $(BUILD_DIR)/zrythm_$(ZRYTHM_VERSION)_debian10_x86_64.deb

# Ubuntu 19.04 target to be used by ansible inside the
# ubuntu VM
.PHONY: ubuntu1904
ubuntu1904: $(BUILD_DIR)/zrythm_$(ZRYTHM_VERSION)_debian10_x86_64.deb

$(BUILD_DIR)/zrythm_$(ZRYTHM_VERSION)_debian10_x86_64.deb: debian.changelog debian.compat debian.control debian.copyright debian.rules $(BUILD_DIR)/$(ZRYTHM_TARBALL) $(BUILD_DIR)/meson
	rm -rf $(BUILD_DEBIAN10_DIR)
	mkdir -p $(BUILD_DEBIAN10_DIR)
	cp $(BUILD_DIR)/$(ZRYTHM_TARBALL) $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DEBIAN_TARBALL)
	cd $(BUILD_DEBIAN10_DIR) && tar xf $(ZRYTHM_DEBIAN_TARBALL)
	mkdir -p $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/source
	cp debian.changelog $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/changelog
	cp debian.compat $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/compat
	cp debian.control $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/control
	cp debian.copyright $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/copyright
	cp debian.rules $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/rules
	echo "3.0 (quilt)" > $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR)/debian/source/format
	cd $(BUILD_DEBIAN10_DIR)/$(ZRYTHM_DIR) && debuild -us -uc

$(BUILD_DIR)/$(MESON_TARBALL):
	wget https://github.com/mesonbuild/meson/releases/download/0.52.1/$(MESON_TARBALL) -O $@

# target to fetch latest version of git, used whenever
# the meson version is too old
.PHONY: meson
meson: $(BUILD_DIR)/meson

$(BUILD_DIR)/meson: $(BUILD_DIR)/$(MESON_TARBALL)
	cd $(BUILD_DIR) && tar xf $(MESON_TARBALL) && mv $(MESON_DIR) meson

# target for fetching the zrythm release tarball
$(BUILD_DIR)/$(ZRYTHM_TARBALL):
	mkdir -p $(BUILD_DIR)
	wget $(ZRYTHM_TARBALL_URL) -O $@
	wget $(ZRYTHM_TARBALL_URL).$(SUM_EXT) -O $(BUILD_DIR)/$(ZRYTHM_TARBALL_SUM)
	cd $(BUILD_DIR) && $(CALC_SUM) $(ZRYTHM_TARBALL_SUM)
