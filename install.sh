#!/bin/bash

_pkgname=steamos-xpad
_pkgver=0.1
_pkgpath=/usr/src/${_pkgname}-${_pkgver}
_steamos_commit=96053cb77390d18cc76cebead210481ea173bee5

wget https://raw.githubusercontent.com/ValveSoftware/steamos_kernel/${_steamos_commit}/drivers/input/joystick/xpad.c

patch xpad.c -Np4 -i change-name.patch

#sudo dkms uninstall -m ${_pkgname} -v ${_pkgver}
#sudo dkms remove -m ${_pkgname} -v ${_pkgver} --all

echo "installing source"
sudo mkdir -p ${_pkgpath}
sudo cp xpad.c ${_pkgpath}/steamos-xpad.c
sudo cp makefile.dkms ${_pkgpath}/Makefile
sudo cp steamos-xpad.dkms ${_pkgpath}/dkms.conf 

#TODO: more generic dkms.conf with versions/names auto-set
# sed ...

#TODO: blacklist original xpad module

sudo dkms add ${_pkgname}/${_pkgver}
sudo dkms build ${_pkgname}/${_pkgver}
sudo dkms install ${_pkgname}/${_pkgver}
