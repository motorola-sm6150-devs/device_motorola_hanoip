#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit the proprietary files
$(call inherit-product, vendor/motorola/hanoip/hanoip-vendor.mk)

# Bionic
PRODUCT_PRODUCT_PROPERTIES += \
    ro.bionic.cpu_variant=cortex-a76 \
    ro.bionic.2nd_cpu_variant=cortex-a55

# Dalvik
PRODUCT_PRODUCT_PROPERTIES += \
    dalvik.vm.isa.arm64.variant=cortex-a76 \
    dalvik.vm.isa.arm.variant=cortex-a55

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/motorola
