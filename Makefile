CROSSDIR=./arm-eabi-4.8
PREFIX=arm-eabi-
BIN=$(CROSSDIR)/bin
AS=$(BIN)/$(PREFIX)as
OBJCOPY=$(BIN)/$(PREFIX)objcopy
READELF=$(BIN)/$(PREFIX)readelf

DEVICE_DIRECTORY=/sdcard

all: tiny

tiny: main.out
	$(OBJCOPY) $< -O binary $@

main.out: main.asm
	$(AS) -c $< -o $@

clean:
	rm -rf main.out tiny

install: tiny
	adb push tiny $(DEVICE_DIRECTORY)/
	adb push tiny-install.sh $(DEVICE_DIRECTORY)/
	adb shell "su -c '/system/xbin/bash $(DEVICE_DIRECTORY)/tiny-install.sh'"

uninstall:
	adb push tiny-uninstall.sh $(DEVICE_DIRECTORY)/
	adb shell "su -c '/system/xbin/bash $(DEVICE_DIRECTORY)/tiny-uninstall.sh'"

test: install
	./test.sh

readelf: tiny
	$(READELF) -a $<
