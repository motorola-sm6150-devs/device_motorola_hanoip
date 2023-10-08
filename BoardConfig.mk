#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/motorola/hanoip

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a76

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a55

# Assert
TARGET_OTA_ASSERT_DEVICE := hanoip

# Board
TARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/board-info.txt
TARGET_BOARD_PLATFORM := sm6150
TARGET_BOOTLOADER_BOARD_NAME := hanoip

# Kernel
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_CMDLINE := \
    console=ttyMSM0,115200n8 \
    androidboot.hardware=qcom \
    androidboot.console=ttyMSM0 \
    androidboot.memcg=1 \
    lpm_levels.sleep_disabled=1 \
    video=vfb:640x400,bpp=32,memsize=3072000 \
    msm_rtb.filter=0x237 \
    service_locator.enable=1 \
    swiotlb=1 \
    androidboot.usbcontroller=a600000.dwc3 \
    earlycon=msm_geni_serial,0x880000 \
    loop.max_part=7 \
    printk.devkmsg=on \
    firmware_class.path=/vendor/firmware_mnt/image \
    androidboot.hab.csv=17 \
    androidboot.hab.product=hanoip \
    androidboot.hab.cid=50

BOARD_BOOT_HEADER_VERSION := 3
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_INCLUDE_DTB_IN_BOOTIMG := true

include device/motorola/hanoip-kernel/BoardConfigKernel.mk

# Partitions
BOARD_USES_METADATA_PARTITION := true
BOARD_USES_RECOVERY_AS_BOOT := true

BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_DTBOIMG_PARTITION_SIZE := 25165824
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864

SSI_PARTITIONS := product system system_ext
TREBLE_PARTITIONS := vendor
ALL_PARTITIONS := $(SSI_PARTITIONS) $(TREBLE_PARTITIONS)

$(foreach p, $(call to-upper, $(ALL_PARTITIONS)), \
    $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := ext4) \
    $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))

# Partitions (Dynamic)
BOARD_SUPER_PARTITION_SIZE := 10804527104
BOARD_SUPER_PARTITION_GROUPS := mot_dynamic_partitions
BOARD_MOT_DYNAMIC_PARTITIONS_SIZE := 10800332800
BOARD_MOT_DYNAMIC_PARTITIONS_PARTITION_LIST := $(ALL_PARTITIONS)

ifneq ($(WITH_GMS),true)
$(foreach p, $(call to-upper, $(SSI_PARTITIONS)), \
    $(eval BOARD_$(p)IMAGE_EXTFS_INODE_COUNT := -1))
SSI_PARTITIONS_RESERVED_SIZE := 1048576000
else
SSI_PARTITIONS_RESERVED_SIZE := 52428800
endif
$(foreach p, $(call to-upper, $(SSI_PARTITIONS)), \
    $(eval BOARD_$(p)IMAGE_PARTITION_RESERVED_SIZE := $(SSI_PARTITIONS_RESERVED_SIZE)))
$(foreach p, $(call to-upper, $(TREBLE_PARTITIONS)), \
    $(eval BOARD_$(p)IMAGE_PARTITION_RESERVED_SIZE := 52428800))

# Inherit from the proprietary version
include vendor/motorola/hanoip/BoardConfigVendor.mk
