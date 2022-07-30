#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

RECOVERY_KMOD_TARGETS += \
    mmi_relay.ko \
    mmi_annotate.ko \
    mmi_info.ko \
    stmicro_mmi.ko \
    touchscreen_mmi.ko

-include device/motorola/sm8250-common/AndroidBoardCommon.mk
