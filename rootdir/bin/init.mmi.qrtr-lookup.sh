#!/vendor/bin/sh

echo "Save qrtr lookup logs"
qrtr_log=/data/vendor/dontpanic/qrtr-lookup.log

/vendor/bin/qrtr-lookup > $qrtr_log
/vendor/bin/chmod 640 $qrtr_log

exit 0
