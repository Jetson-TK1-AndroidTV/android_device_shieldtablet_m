TARGET_KERNEL_DT_NAME ?= tegra124-tn8

include device/nvidia/platform/ardbeg/BoardConfig.mk

TARGET_DEVICE := shieldtablet
REFERENCE_DEVICE := shieldtablet
TARGET_SYSTEM_PROP := device/nvidia/platform/ardbeg/system.prop

APPFILTERCLASS := com.nvidia.appfilter

# Raydium library version to be used
RAYDIUM_PRODUCT_BRANCH := dev-kernel-shieldtablet8

# OTA
TARGET_RECOVERY_FSTAB := device/nvidia/platform/ardbeg/fstab.tn8

# Sensor package definition
# PRODUCT_* variables are defined in 'product.mk' file:
include device/nvidia/platform/shieldtablet/sensors-common.mk
#PRODUCT_PROPERTY_OVERRIDES	+= ro.hardware.sensors=$(SENSOR_BUILD_VERSION).$(SENSOR_FUSION_VERSION).$(SENSOR_HAL_VERSION)
#PRODUCT_PACKAGES		+= sensors.$(SENSOR_BUILD_VERSION).$(SENSOR_FUSION_VERSION).$(SENSOR_HAL_VERSION)
#SENSOR_BUILD_VERSION    := default	defined in sensors-common.mk
#SENSOR_HAL_VERSION      := nvs		defined in sensors-common.mk
#SENSOR_FUSION_VERSION   := mpl520	defined in sensors-common.mk

# sepolicy
# try to detect AOSP master-based policy vs small KitKat policy
ifeq ($(wildcard external/sepolicy/lmkd.te),)
# KitKat based board specific sepolicy
BOARD_SEPOLICY_DIRS += device/nvidia/platform/shieldtablet/products/sepolicy/
else
# AOSP master based board specific sepolicy
BOARD_SEPOLICY_DIRS += device/nvidia/platform/shieldtablet/products/sepolicy_aosp/
endif

# Double buffered display surfaces reduce memory usage, but will decrease performance.
# The default is to triple buffer the display surfaces.
BOARD_DISABLE_TRIPLE_BUFFERED_DISPLAY_SURFACES := true

# clear variables that ST8 doesn't need
TARGET_KERNEL_VCM_BUILD :=
TARGET_QUICKBOOT :=
TARGET_QUICKBOOT_PRODUCTION_CONFIG :=
QUICKBOOT_PRODUCTION_CONFIG :=
QUICKBOOT_DEFAULT_CONFIG :=
TARGET_BOOT_MEDIUM :=
QUICKBOOT_TARGET_OS :=
TARGET_QB_FLASH_TOOL :=
