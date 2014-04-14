MYDIR=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
mount -o rw,remount /system
cp $MYDIR/tiny /system/bin/
chmod 777 /system/bin/tiny
mount -o ro,remount /system
rm $MYDIR/tiny
rm $MYDIR/tiny-install.sh

