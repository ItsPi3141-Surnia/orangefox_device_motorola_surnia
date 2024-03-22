#
# Copyright (C) 2015-2016 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/motorola/surnia

TARGET_ARCH := arm
TARGET_CPU_ABI  := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a7
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_SMP := true
ARCH_ARM_HAVE_TLS_REGISTER := true

# Deprecated
# TARGET_GLOBAL_CFLAGS += -mfpu=neon -mfloat-abi=softfp
# TARGET_GLOBAL_CPPFLAGS += -mfpu=neon -mfloat-abi=softfp

TARGET_BOARD_PLATFORM := msm8916

TARGET_BOOTLOADER_BOARD_NAME := MSM8916
TARGET_NO_BOOTLOADER := true

# BOARD_KERNEL_CMDLINE := androidboot.hardware=qcom ehci-hcd.park=3 vmalloc=400M androidboot.bootdevice=7824900.sdhci movablecore=160M androidboot.selinux=permissive
BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8 androidboot.console=ttyHSL0 androidboot.hardware=qcom msm_rtb.filter=0x3F ehci-hcd.park=3 vmalloc=400M androidboot.bootdevice=7824900.sdhci utags.blkdev=/dev/block/bootdevice/by-name/utags utags.backup=/dev/block/bootdevice/by-name/utagsBackup movablecore=160M androidboot.selinux=disabled

BOARD_KERNEL_IMAGE_NAME := zImage
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_RAMDISK_OFFSET := 0x01000000
# These are just for reference
# BOARD_KERNEL_OFFSET := 0x00008000
# BOARD_KERNEL_SECOND_OFFSET := 0x00f00000
# BOARD_KERNEL_TAGS_OFFSET := 0x00000100
# BOARD_DTB_OFFSET := 0x00000000

# Prebuilt
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/$(BOARD_KERNEL_IMAGE_NAME)
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dt.img

# We aren't building the kernel because it's already prebuilt
# TARGET_KERNEL_SOURCE := kernel/motorola/msm8916
# TARGET_KERNEL_CONFIG := surnia_defconfig

# usage: mkbootimg
#        --kernel <filename>
#        --ramdisk <filename>
#        [ --second <2ndbootloader-filename> ]
#        [ --cmdline <kernel-commandline> ]
#        [ --board <boardname> ]
#        [ --base <address> ]
#        [ --pagesize <pagesize> ]
#        [ --ramdisk_offset <address> ]
#        [ --dt <filename> ]
#        -o|--output <filename>
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset $(BOARD_RAMDISK_OFFSET) 
# BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET) --second_offset $(BOARD_KERNEL_SECOND_OFFSET)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_MKBOOTIMG_ARGS += --dt $(TARGET_PREBUILT_DTB)
# Output is specified in bootimg.mk

BOARD_CUSTOM_BOOTIMG_MK := $(DEVICE_PATH)/bootimg.mk

BOARD_USES_QCOM_HARDWARE := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TARGET_USES_MOTOROLA_LOG := true

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

TARGET_RECOVERY_FSTAB := device/motorola/surnia/twrp.fstab

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE := 33554432      # 32768 * 1024 mmcblk0p33
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 33538048  # 32752 * 1024 mmcblk0p34
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1895825408  # 1851392 * 1024 mmcblk0p42
BOARD_PERSISTIMAGE_PARTITION_SIZE := 8388608    # 8192 * 1024 mmcblk0p31
BOARD_USERDATAIMAGE_PARTITION_SIZE := 5368578048 # 5242752 * 1024 mmcblk0p44

# don't take forever to wipe
BOARD_SUPPRESS_SECURE_ERASE := true
COMMON_GLOBAL_CFLAGS += -DNO_SECURE_DISCARD

# Crypto
TARGET_HW_DISK_ENCRYPTION := true
TW_INCLUDE_CRYPTO := true

# TWRP
TW_IGNORE_MAJOR_AXIS_0 := true

# Screen
DEVICE_RESOLUTION := 540x960
TARGET_SCREEN_WIDTH := 540
TARGET_SCREEN_HEIGHT := 960

# TARGET_RECOVERY_PIXEL_FORMAT := RGB_565
TARGET_RECOVERY_PIXEL_FORMAT := RGBA_8888
TW_NEW_ION_HEAP := true
RECOVERY_GRAPHICS_USE_LINELENGTH := true
TW_SCREEN_BLANK_ON_BOOT := true
TW_IGNORE_MAJOR_AXIS_0 := true

TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/msm_hsusb/gadget/lun%d/file