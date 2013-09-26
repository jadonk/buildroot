################################################################################
#
# autorun
#
################################################################################

AUTORUN_VERSION = 0.0.1
AUTORUN_SITE = package/autorun/src
AUTORUN_SITE_METHOD = local
AUTORUN_INSTALL_STAGING = 

define AUTORUN_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D package/autorun/S99autorun \
		$(TARGET_DIR)/etc/init.d/S99autorun
endef

$(eval $(generic-package))
