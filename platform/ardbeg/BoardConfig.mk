TARGET_BOARD_PLATFORM := tegra
TARGET_TEGRA_VERSION := t124
TARGET_TEGRA_FAMILY := t12x

# CPU options
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a15
TARGET_CPU_SMP := true

BOARD_BUILD_BOOTLOADER := true

TARGET_KERNEL_DT_NAME ?= tegra124-ardbeg

REFERENCE_DEVICE := ardbeg

ifeq ($(NO_ROOT_DEVICE),1)
  TARGET_PROVIDES_INIT_RC := true
else
  TARGET_PROVIDES_INIT_RC := false
endif

BOARD_USES_GENERIC_AUDIO := false
BOARD_USES_ALSA_AUDIO := true

ifeq ($(NV_ANDROID_FRAMEWORK_ENHANCEMENTS), TRUE)
USE_CUSTOM_AUDIO_POLICY := 1
else
USE_CUSTOM_AUDIO_POLICY := 0
endif

BOARD_SUPPORT_NVOICE := true
BOARD_SUPPORT_NVAUDIOFX := true

TARGET_COPY_OUT_VENDOR := vendor
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 16777216
BOARD_USERDATAIMAGE_PARTITION_SIZE  := 13090422784
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1342177280
BOARD_VENDORIMAGE_PARTITION_SIZE := 419430400
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE := 805306368
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 4096

# MKBOOTIMG
# TARGET_NO_KERNEL = false
TARGET_KERNEL_APPEND_DTB := true
TARGET_BUILD_KERNEL_MODULES := true
TARGET_KERNEL_HAVE_EXFAT =: true
TARGET_KERNEL_HAVE_NTSF =: true
BOARD_KERNEL_IMAGE_NAME := zImage-dtb
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_CMDLINE := androidboot.hardware=jetson-tk1 vmalloc=500M androidboot.selinux=permissive
BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x01000000 --ramdisk_offset 0x02100000 --tags_offset 0x02000000

BOARD_SUPPORT_PARAGON_FUSE_UFSD := true

USE_OPENGL_RENDERER := true

# OTA
TARGET_RECOVERY_UPDATER_LIBS += libnvrecoveryupdater
TARGET_RECOVERY_UI_LIB := librecovery_ui_default
TARGET_RECOVERY_UPDATER_EXTRA_LIBS += libfs_mgr
TARGET_RECOVERY_FSTAB = device/nvidia/platform/ardbeg/fstab.ardbeg

BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR ?= device/nvidia/platform/ardbeg/bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true

# powerhal
BOARD_USES_POWERHAL := true

# Sensor package definition
# PRODUCT_* variables are defined in 'product.mk' file:
include device/nvidia/platform/ardbeg/sensors-common.mk
#PRODUCT_PROPERTY_OVERRIDES	+= ro.hardware.sensors=$(SENSOR_BUILD_VERSION).$(SENSOR_FUSION_VERSION).$(SENSOR_HAL_VERSION)
#PRODUCT_PACKAGES		+= sensors.$(SENSOR_BUILD_VERSION).$(SENSOR_FUSION_VERSION).$(SENSOR_HAL_VERSION)
#SENSOR_BUILD_VERSION    := default	defined in sensors-common.mk
#SENSOR_HAL_VERSION      := nvs		defined in sensors-common.mk
#SENSOR_FUSION_VERSION   := mpl520	defined in sensors-common.mk

# Temp WAR for Android-M
# Wifi related defines
BOARD_WIFI_CHIP             := BCM43241
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
WPA_SUPPLICANT_VERSION      := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_WLAN_DEVICE           := bcmdhd
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_bcmdhd
WIFI_DRIVER_FW_PATH_STA     := "/data/misc/wifi/firmware/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_AP      := "/data/misc/wifi/firmware/fw_bcmdhd_apsta.bin"
WIFI_DRIVER_FW_PATH_P2P     := "/data/misc/wifi/firmware/fw_bcmdhd_p2p.bin"
WIFI_DRIVER_FW_PATH_PARAM   := "/data/misc/wifi/firmware/firmware_path"
WIFI_DRIVER_MODULE_ARG      := "iface_name=wlan0"
WIFI_DRIVER_MODULE_NAME     := "bcmdhd"

# GPS
BOARD_GPS_LIBRARIES := true

# Default HDMI mirror mode
# Crop (default) picks closest mode, crops to screen resolution
# Scale picks closest mode, scales to screen resolution (aspect preserved)
# Center picks a mode greater than or equal to the panel size and centers;
#     if no suitable mode is available, reverts to scale
BOARD_HDMI_MIRROR_MODE := Scale

# NVDPS can be enabled when display is set to continuous mode.
BOARD_HAS_NVDPS := true

# Allow this variable to be overridden to n for non-secure OS build
SECURE_OS_BUILD ?= y
ifeq ($(SECURE_OS_BUILD),y)
    SECURE_OS_BUILD := tlk
endif

# Use Nvidia optimized renderscript driver
OVERRIDE_RS_DRIVER := libnvRSDriver.so

# Double buffered display surfaces reduce memory usage, but will decrease performance.
# The default is to triple buffer the display surfaces.
# BOARD_DISABLE_TRIPLE_BUFFERED_DISPLAY_SURFACES := true

include device/nvidia/common/BoardConfig.mk

# Use CMU-style config with Nvcms
NVCMS_CMU_USE_CONFIG := false

-include 3rdparty/trustedlogic/samples/hdcp/tegra3/build/arm_android/config.mk

# Icera modem definitions
-include device/nvidia/common/icera/BoardConfigIcera.mk

# Raydium touch definitions
include device/nvidia/drivers/touchscreen/raydium/BoardConfigRaydium.mk

# Maxim touch definitions
include device/nvidia/drivers/touchscreen/maxim/BoardConfigMaxim.mk

# BOARD_WIDEVINE_OEMCRYPTO_LEVEL
# The security level of the content protection provided by the Widevine DRM plugin depends
# on the security capabilities of the underlying hardware platform.
# There are Level 1/2/3. To run HD contents, should be Widevine level 1 security.
BOARD_WIDEVINE_OEMCRYPTO_LEVEL := 1

# Dalvik option
DALVIK_ENABLE_DYNAMIC_GC := true

# Using the NCT partition
TARGET_USE_NCT := true
# LBH related defines
# use LBH partition and resources in it
BOARD_HAVE_LBH_SUPPORT := true

#Use tegra health HAL library
BOARD_HAL_STATIC_LIBRARIES := libhealthd.tegra

#Display static images for charging
BOARD_CHARGER_STATIC_IMAGE := true

#Shutdown on charge complete, from charging loop
BOARD_CHARGER_SHUTDOWN_ON_COMPLETE := true

# sepolicy
BOARD_SEPOLICY_DIRS += device/nvidia/platform/ardbeg/sepolicy/

# Per-application sizes for shader cache
MAX_EGL_CACHE_SIZE := 128450560
MAX_EGL_CACHE_ENTRY_SIZE := 262144

ifeq ($(wildcard vendor/nvidia/tegra/core-private),vendor/nvidia/tegra/core-private)
    NVFLASH_FILES_PATH := vendor/nvidia/tegra/bootloader/nvbootloader/odm-partner/ardbeg
else
    NVFLASH_FILES_PATH := vendor/nvidia/tegra/odm/ardbeg
endif
NVFLASH_CFG_BASE_FILE := $(NVFLASH_FILES_PATH)/nvflash/tn8_android_fastboot_nvtboot_dtb_emmc_full.cfg
NVFLASH_FILES_PATH :=
