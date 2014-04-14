MYDIR=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
mount -o rw,remount /system
rm /system/bin/tiny
mount -o ro,remount /system
rm $MYDIR/tiny-uninstall.sh
