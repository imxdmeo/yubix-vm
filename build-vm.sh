#!/bin/bash

set -e

DIR="$( cd "$( dirname "$0" )" && pwd )"

HYPERVISOR="vmw6"
DIST="ubuntu"

VMBUILDER_ARGS="--suite precise --arch i386 --flavour virtual \
--mem 300 --tmpfs - --hostname yubi-x --user yubikey --pass yubico \
--exec $DIR/exec.sh --firstboot $DIR/firstboot.sh \
--ppa yubico/stable --addpkg unattended-upgrades --addpkg yubi-x \
--addpkg pwgen"

vmbuilder $HYPERVISOR $DIST $VMBUILDER_ARGS $@

if [ $HYPERVISOR == "vmw6" ]; then
	#Fix path of the virtual hdd.
	sed -i s,$DIR/$DIST-$HYPERVISOR/,,g $DIST-$HYPERVISOR/yubi-x.vmx
fi

echo "Completed successfully!"
