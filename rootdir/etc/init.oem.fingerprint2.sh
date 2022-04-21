#!/vendor/bin/sh
# Determine fingerprint sensor
if [ ! -f /mnt/vendor/persist/fps/vendor_id ];
then
fps_id="none"
else
fps_id=$(cat /mnt/vendor/persist/fps/vendor_id)
fi
# Set fingerprint vendor
prop_persist_fps=persist.vendor.hardware.fingerprint
# this property store FPS_STATUS_NONE or FPS_STATUS_OK
# after start fingerprint hal service, the hal service will set this property.
prop_fps_status=vendor.hw.fingerprint.status

set_permissions() {
    if [ "$fps_id" = "fpc" ]
    then
        chown system:system /sys/class/fingerprint/fpc1020/irq
    else
        chmod 0660 /dev/esfp0
        chown system:system /dev/esfp0
    fi
}

start_fpsensor() {
    if [ "$fps_id" = "fpc" ]
    then
        insmod /vendor/lib/modules/fpc1020_mmi.ko
        sleep 0.6
        set_permissions
        sleep 0.4
        start fps_hal
        sleep 1
        value=$(getprop "$prop_fps_status")
        if [ "$value" = "ok" ];
        then
            setprop "$prop_persist_fps" "$fps_id"
        fi
    else
        insmod /vendor/lib/modules/ets_fps_mmi.ko
        sleep 0.6
        set_permissions
        sleep 0.4
        start ets_hal
        sleep 1
        value=$(getprop "$prop_fps_status")
        if [ "$value" = "ok" ];
        then
            setprop "$prop_persist_fps" "$fps_id"
        fi
    fi
}

rmmod ets_fps_mmi
rmmod fpc1020_mmi
sleep 0.5
if [ "$fps_id" = "none" ];
then
    fps_id=$(cat /mnt/vendor/persist/fps/last_vendor_id)
fi
start_fpsensor
