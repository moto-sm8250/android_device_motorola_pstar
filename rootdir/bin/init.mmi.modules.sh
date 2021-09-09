#!/vendor/bin/sh

# All modules that depend on conditions or need extra parameters
# should go here.

buildtype=$(getprop ro.build.type)
if [ $buildtype = "userdebug" ]; then
    insmod /vendor/lib/modules/watchdogtest.ko
fi
