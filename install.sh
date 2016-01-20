#!/bin/bash

# git clone https://github.com/ValveSoftware/steamos_kernel.git
# cd steamos_kernel
# echo "$(git rev-parse --abbrev-ref HEAD).$(git log -n 1 --pretty=format:%h -- drivers/input/joystick/xpad.c)" | sed 's/-/./g'_pkgname=steamos-xpad
_steamos_commit=96053cb77390d18cc76cebead210481ea173bee5

_pkgver=0.1
_pkgpath=/usr/src/${_pkgname}-${_pkgver}

wget https://raw.githubusercontent.com/ValveSoftware/steamos_kernel/${_steamos_commit}/drivers/input/joystick/xpad.c 

patch xpad.c -Np4 -i change-name.patch

#TODO: uninstall/remove existing version
#sudo dkms uninstall ${_pkgname}/${_pkgver}
#sudo dkms remove ${_pkgname}/${_pkgver} --all

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
