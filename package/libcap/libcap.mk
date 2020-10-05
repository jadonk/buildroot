################################################################################
#
# libcap
#
################################################################################

LIBCAP_VERSION = 2.43
LIBCAP_SITE = https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2
LIBCAP_SOURCE = libcap-$(LIBCAP_VERSION).tar.xz
LIBCAP_LICENSE = GPL-2.0 or BSD-3-Clause
LIBCAP_LICENSE_FILES = License

LIBCAP_DEPENDENCIES = host-libcap host-gperf
LIBCAP_INSTALL_STAGING = YES

HOST_LIBCAP_DEPENDENCIES = host-gperf

LIBCAP_MAKE_FLAGS = \
	BUILD_CC="$(HOSTCC)" \
	BUILD_CFLAGS="$(HOST_CFLAGS)" \
	DYNAMIC=$(if $(BR2_STATIC_LIBS),,yes)

LIBCAP_MAKE_DIRS = libcap

ifeq ($(BR2_PACKAGE_LIBCAP_TOOLS),y)
LIBCAP_MAKE_DIRS += progs
endif

define LIBCAP_BUILD_CMDS
	$(foreach d,$(LIBCAP_MAKE_DIRS), \
		$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/$(d) \
			$(LIBCAP_MAKE_FLAGS) all
	)
endef

define LIBCAP_INSTALL_STAGING_CMDS
	$(foreach d,$(LIBCAP_MAKE_DIRS), \
		$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/$(d) $(LIBCAP_MAKE_FLAGS) \
			DESTDIR=$(STAGING_DIR) prefix=/usr lib=lib install
	)
endef

define LIBCAP_INSTALL_TARGET_CMDS
	$(foreach d,$(LIBCAP_MAKE_DIRS), \
		$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/$(d) $(LIBCAP_MAKE_FLAGS) \
			DESTDIR=$(TARGET_DIR) prefix=/usr lib=lib install
	)
endef

define HOST_LIBCAP_BUILD_CMDS
	$(HOST_MAKE_ENV) $(HOST_CONFIGURE_OPTS) $(MAKE) -C $(@D)\
		DYNAMIC=yes \
		RAISE_SETFCAP=no GOLANG=no
endef

define HOST_LIBCAP_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) prefix=$(HOST_DIR) \
		DYNAMIC=yes \
		RAISE_SETFCAP=no GOLANG=no lib=lib install
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
