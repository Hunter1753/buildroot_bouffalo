################################################################################
#
# afboot-stm32
#
################################################################################

OBLFR_VERSION = 4411c949b4dd38e21fbc86c5a5dbb74616097c68
OBLFR_SITE = $(call github,Hunter1753,OBLFR,$(OBLFR_VERSION))
OBLFR_INSTALL_IMAGES = YES
OBLFR_INSTALL_TARGET = NO
OBLFR_DEPENDENCIES = host-blmcusdk host-python3

define OBLFR_BUILD_CMDS
	cd $(@D)/apps/d0_lowload && BL_SDK_BASE=$(HOST_DIR)/opt/bl_mcu_sdk $(TARGET_MAKE_ENV) $(CLOUDUTILS_MAKE_ENV) $(MAKE) -C $(@D)/apps/d0_lowload
	cd $(@D)/apps/m0_lowload && BL_SDK_BASE=$(HOST_DIR)/opt/bl_mcu_sdk $(TARGET_MAKE_ENV) $(CLOUDUTILS_MAKE_ENV) $(MAKE) -C $(@D)/apps/m0_lowload
endef

define OBLFR_INSTALL_IMAGES_CMDS
	$(INSTALL) -m 0755 -t $(BINARIES_DIR) -D $(@D)/apps/d0_lowload/build/build_out/*.bin
	$(INSTALL) -m 0755 -t $(BINARIES_DIR) -D $(@D)/apps/m0_lowload/build/build_out/*.bin
endef

$(eval $(generic-package))
