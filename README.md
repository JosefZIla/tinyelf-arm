This is minimal executable ELF binary for ARM, that just returns exit code 42. 

Instructions:
=============
* $ git submodule init
* $ git submodule update
* $ make

This will produce binary called tiny, it is 48 bytes long.

If you have rooted android phone with bash in /system/xbin/, you can also use following commands:

* $ make install   -   to install binary through ADB to /system/bin.
* $ make test      -   install and run binary through ADB and check if exit code is correct
* $ make uninstall -   remove binary from the device

Inspiration from http://www.muppetlabs.com/~breadbox/software/tiny/teensy.html

