#! /bin/bash
# VMWare Workstation/Player _host kernel modules_ patcher by Willy Sudiarto Raharjo
# Updated for VMware 10.0.6 on kernel 4.1
# Use at your own risk.
# Credit goes to ArchLinux
# https://wiki.archlinux.org/index.php/VMware

vmnet=vmnet-4.1.patch
vmreqver=10.0.6
plreqver=7.1.2


error()
{
	echo "$*. Exiting"
	exit
}

curdir=`pwd`
bdate=`date "+%F-%H:%M:%S"` || error "date utility didn't quite work. Hm"
vmver=`vmware-installer -l 2>/dev/null | awk '/vmware-/{print $1substr($2,1,6)}'`
vmver="${vmver#vmware-}"
basedir=/usr/lib/vmware/modules/source
ptoken="$basedir/.patched"
bkupdir="$basedir-$vmver-$bdate-backup"

unset product
[ -z "$vmver" ] && error "VMWare is not installed (properly) on this PC"
[ "$vmver" == "workstation$vmreqver" ] && product="VMWare WorkStation"
[ "$vmver" == "player$plreqver" ] && product="VMWare Player"
[ -z "$product" ] && error "Sorry, this script is only for VMWare WorkStation $vmreqver or VMWare Player $plreqver"

[ "`id -u`" != "0" ] && error "You must be root to run this script"
[ -f "$ptoken" ] && error "$ptoken found. You have already patched your sources"
[ ! -d "$basedir" ] && error "Source '$basedir' directory not found, reinstall $product"
[ ! -f "$vmnet" ] && error "'$vmnet' not found. Please, copy it to the current '$curdir' directory"

tmpdir=`mktemp -d` || exit 1
cp -an "$basedir" "$bkupdir" || exit 2

cd "$tmpdir" || exit 3
find "$basedir" -name "*.tar" -exec tar xf '{}' \; || exit 4

cd vmnet-only
patch -p1 < "$curdir/$vmnet" || exit 5
cd ..
tar cf vmnet.tar vmnet-only || exit 6

cp -a *.tar "$basedir" || exit 20
rm -rf "$tmpdir" || exit 21
touch "$ptoken" || exit 22
cd "$curdir" || exit 23

vmware-modconfig --console --install-all

echo -e "\n"
echo "All done, you can now run $product."
echo "Modules sources backup can be found in the '$bkupdir' directory"
