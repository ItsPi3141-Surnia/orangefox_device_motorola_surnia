#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2021-2023 The OrangeFox Recovery Project
#	
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
# 	
# 	Please maintain this if you use this script or any part of it
#
FDEVICE="surnia"

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep \"$FDEVICE\")
   if [ -n "$chkdev" ]; then
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep \"$FDEVICE\")
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
    # Stanard stuff
    export ALLOW_MISSING_DEPENDENCIES=true
    export LC_ALL="C"

    export FOX_TARGET_DEVICES=surnia

    export FOX_VANILLA_BUILD=1
    export FOX_NO_SAMSUNG_SPECIAL=1
    export TARGET_ARCH=arm
    export OF_USE_LZMA_COMPRESSION=1

   	export TW_DEFAULT_LANGUAGE="en"
    export TW_THEME=portrait_hdpi
    export TW_MAX_BRIGHTNESS=255
    export OF_DISABLE_MIUI_SPECIFIC_FEATURES=1
    export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
	export OF_USE_GREEN_LED=0
    export OF_FLASHLIGHT_ENABLE=0
    export OF_ALLOW_DISABLE_NAVBAR=0

	# Screen
    export OF_SCREEN_H=960
    export OF_STATUS_H=36
    export OF_STATUS_INDENT_LEFT=0
    export OF_STATUS_INDENT_RIGHT=0
fi
