#!/bin/bash
# 作用： 一键挂载磁盘脚本
# 作者：jed.fang
# 维护： sober.wang,sakoo.jiang
# e-mail: sober.wang@dbappsecurity.com.cn

setup_path=/home
if [ -n "$1" ]; then
    setup_path=$1
fi
if [ ! -d "$setup_path" ]; then
    mkdir "$setup_path"
fi
reg_setup_path=${setup_path/\//\\\\\/}
function createLvm() {
    #检测磁盘数量
    hasmountdisk=$(lsblk | awk '{print $1}' | grep "1" | grep -Eo ".d.")
    mountdisklist=$(lsblk | grep disk | awk '{print $1}')
    if [[ ${hasmountdisk} == ${mountdisklist} ]] ;then
      lsblk |grep ${setup_path}
      exit 0
    fi
    for var in ${mountdisklist}; do
        [[ ${hasmountdisk[@]/${var}/} != ${hasmountdisk[@]} ]] && echo "exist" || sysDisk=${var}
    done
    #parted -s /dev/${sysDisk} mklabel msdos
    #parted -s /dev/${sysDisk} "mkpart ' ' 0 -1"
    #parted /dev/${sysDisk} mkpart primary 0% 100%
    #parted -s /dev/${sysDisk} toggle 1 lvm
    pvcreate /dev/${sysDisk}
    vgcreate vgdata /dev/${sysDisk}
    lvcreate -l +100%FREE -n lvdata vgdata
    mkfs.xfs -f /dev/mapper/vgdata-lvdata
    mount /dev/mapper/vgdata-lvdata ${setup_path}
    if [[ ! $(cat /etc/fstab | grep "${setup_path}") ]]; then
        echo "/dev/mapper/vgdata-lvdata ${setup_path}    xfs    defaults    0    0" >>/etc/fstab
    else
        cp /etc/fstab /etc/fstab$(date "+%Y%m%d%H%M%S")
        sed -i "/.* ${reg_setup_path} .*/d" /etc/fstab
        echo "/dev/mapper/vgdata-lvdata ${setup_path}    xfs    defaults    0    0" >>/etc/fstab
    fi
}
createLvm
lsblk |grep ${setup_path}