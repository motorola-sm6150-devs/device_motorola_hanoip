#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common LineageOS stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from hanoip device
$(call inherit-product, device/motorola/hanoip/device.mk)

PRODUCT_NAME := lineage_hanoip
PRODUCT_DEVICE := hanoip
PRODUCT_MANUFACTURER := motorola
PRODUCT_BRAND := motorola
PRODUCT_MODEL := moto g(60)

PRODUCT_GMS_CLIENTID_BASE := android-motorola

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="hanoip_retail-user 12 S2RIS32.32-20-7-4 41d937-0279a release-keys" \
    TARGET_PRODUCT=hanoip_retail

BUILD_FINGERPRINT := motorola/hanoip_retail/hanoip:12/S2RIS32.32-20-7-4/41d937-0279a:user/release-keys
