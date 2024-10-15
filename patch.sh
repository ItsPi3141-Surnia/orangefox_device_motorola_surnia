#!/bin/bash

. build/envsetup.sh
ANDROID_DIR=${PWD}

echo "Setting root of the Android tree to ${ANDROID_DIR}"

NOCOLOR='\033[0m'
GREEN='\033[0;32m'
LIGHTBLUE='\033[1;34m'

function patch {
    echo -e "${GREEN}Applying ${1}${NOCOLOR}"
    echo -e "${LIGHTBLUE}To ${2}${NOCOLOR}"
    echo ""
    cd $ANDROID_DIR/$2
    git apply $ANDROID_DIR/patches/$1
    cd $ANDROID_DIR
    echo "Applied patch"
    echo ""
}

patch 0001-libbinder.patch /frameworks/native/
patch 0002-qcom-cryptfs_hw.patch /device/qcom/common/