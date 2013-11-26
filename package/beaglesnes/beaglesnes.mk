##############
#
# beaglesnes
#
##############

BEAGLESNES_VERSION = 0.4
BEAGLESNES_SOURCE = beaglesnes_src.tar.bz2
BEAGLESNES_SITE = http://downloads.sourceforge.net/project/beaglesnes/v$(BEAGLESNES_VERSION)%20Release
BEAGLESNES_LICENSE_FILES = docs/beaglesnes-license.txt docs/snes9x-license.txt
BEAGLESNES_DEPENDENCIES = sdl sdl_ttf sdl_image sdl_mixer libpng
BEAGLESNES_SUBDIR = sdl
BEAGLESNES_AUTORECONF = YES
BEAGLESNES_CONF_OPT = \
	$(if $(BR2_ARM_CPU_HAS_NEON),--enable-neon,--disable-neon)
BEAGLESNES_CONF_ENV = \
	snes9x_cv_sdl=yes \
	snes9x_cv_option_o3=yes \
	snes9x_cv_option_omit_frame_pointer=yes \
	snes9x_cv_option_no_exceptions=yes \
	snes9x_cv_option_no_rtti=yes \
	snes9x_cv_option_pedantic=yes \
	snes9x_cv_option_Wall=yes \
	snes9x_cv_option_W=yes \
	snes9x_cv_option_Wno_unused_parameter=yes \
	snes9x_cv_option_mfpu=yes \
	snes9x_cv_option_march=yes \
	snes9x_cv_option_prefetch=yes \
	snes9x_sar_int8=yes \
	snes9x_sar_int16=yes \
	snes9x_sar_int32=yes \
	snes9x_sar_int64=yes

# The archive might have lingering object files
define BEAGLESNES_POST_EXTRACT_RM_DOT_O
	rm $(@D)/*/*.o
endef
BEAGLESNES_POST_EXTRACT_HOOKS += BEAGLESNES_POST_EXTRACT_RM_DOT_O

# Install the executable
define BEAGLESNES_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/sdl/snes9x-sdl $(TARGET_DIR)/usr/bin
endef

$(eval $(autotools-package))
