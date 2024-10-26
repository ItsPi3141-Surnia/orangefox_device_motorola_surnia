# OrangeFox tree for Moto E LTE (2015)

**This is still a WIP. Don't expect it to work.**

Make sure you use Linux. If you have Windows, use WSL.

## ⚙️ Kernel source

kernel (zImage) and device tree blob (dt.img) are already compiled  
source: [MOTO-M8916/android_kernel_motorola_msm8916](https://github.com/MOTO-M8916/android_kernel_motorola_msm8916)

## 🛠️ How to build

### Prepare build environment

```bash
cd ~
sudo apt install git aria2 -y
git clone https://gitlab.com/OrangeFox/misc/scripts
cd scripts
sudo bash setup/android_build_env.sh
sudo bash setup/install_android_sdk.sh
```

### Download OrangeFox

```bash
mkdir ~/OrangeFox_sync
cd ~/OrangeFox_sync
git clone https://gitlab.com/OrangeFox/sync.git
cd ~/OrangeFox_sync/sync/
./orangefox_sync.sh --branch 12.1 --path ~/fox_12.1
```

### Download the device tree

```bash
cd ~/fox_12.1
git clone -b orangefox-12.1 https://github.com/ItsPi3141-Surnia/orangefox_device_motorola_surnia.git device/motorola/surnia/
```

### Download additional dependencies

#### qcom common

```bash
rm -rf ./device/qcom/common
git clone https://github.com/TeamWin/android_device_qcom_common ./device/qcom/common -b android-9.0
cp ./device/motorola/surnia/files/device_qcom_common_cryptfs-hw_Android.bp ./device/qcom/common/cryptfs_hw/Android.bp
```

### Patch

```bash
cp ~/fox_12.1/device/motorola/surnia/patches ~/fox_12.1 -r
cp ~/fox_12.1/device/motorola/surnia/patch.sh ~/fox_12.1
. ~/fox_12.1/patch.sh
```

### Setup environment variables

```bash
export ALLOW_MISSING_DEPENDENCIES=true
export FOX_BUILD_DEVICE=surnia
export LC_ALL="C"
. ./build/envsetup.sh
. ./device/motorola/surnia/vendorsetup.sh
```

> [!TIP]
> If you change variables in vendorsetup.sh, make sure you execute it again

### Build

```bash
lunch twrp_surnia-eng
mka adbd recoveryimage
```

## 💡 Troubleshooting

### `could not make way for new symlink: root/vendor`

```bash
rm -rf out/target/product/surnia/root/vendor
```

## ✨ Extras

### Compiling kernel

Download kernel source and cross compiler

```bash
mkdir ~/surnia-kernel
cd ~/surnia-kernel

git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9 --depth=1 -b ndk-release-r21
git clone https://github.com/MOTO-M8916/android_kernel_motorola_msm8916 -b lineage-19.1 --depth=1
```

Set variables
```bash
export CROSS_COMPILE=~/surnia-kernel/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-
export ARCH=arm && export SUBARCH=arm
```

Build kernel
```bash
cd ~/surnia-kernel/android_kernel_motorola_msm8916
make surnia_defconfig
make -j$(nproc --all)
```