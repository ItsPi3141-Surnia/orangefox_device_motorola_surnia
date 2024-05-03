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

#### cryptfs hw

```bash
git clone https://github.com/LineageOS/android_vendor_qcom_opensource_cryptfs_hw ./vendor/qcom/opensource/commonsys/cryptfs_hw
```

### Patch
```bash
mv ~/fox_12.1/device/motorola/surnia/patches ~/fox_12.1
mv ~/fox_12.1/device/motorola/surnia/patch.sh ~/fox_12.1
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