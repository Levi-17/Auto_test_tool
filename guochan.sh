#!/bin/bash
#首先安装截图工具 sudo apt-get install scrot
#脚本功能
#1.盘的文件系统测试，LVM卷管理测试并且截图
#3.保存完整的测试结果至数据盘中
#4.结果test.img也在数据盘中

#输入2个参数     /dev/sdX1 第一个为系统盘 ----/dev/sdX2 第二个为待测盘

Result_dir='/home/test/Desktop/guochan'

function sd_test()
{
    local filename=$1    #第一个参数
    local fielname2=$2
    smartctl -i $filename
    sleep 1s
    scrot $Result_dir/system_info.png
    echo y | mkfs.ext3 $2
    mount $2 /mnt
    cd /mnt
    dd if=/dev/zero of=test.img bs=1M count=1024 oflag=direct
    sleep 1s
    scrot $Result_dir/ext3.png
    cd ..
    umount $2
    echo y | mkfs.ext4 $2
    mount $2 /mnt
    cd /mnt
    dd if=/dev/zero of=test.img bs=1M count=1024 oflag=direct
    sleep 1s
    scrot $Result_dir/ext4.png
    cd ..
    umount $2
    echo y | mkfs -txfs -f $2
    mount $2 /mnt
    cd /mnt
    dd if=/dev/zero of=test.img bs=1M count=1024 oflag=direct
    sleep 1s
    scrot $Result_dir/txfs.png
    cd ..
    umount $2
    echo y | mkfs -t btrfs -f $2
    mount $2 /mnt
    cd /mnt
    dd if=/dev/zero of=test.img bs=1M count=1024 oflag=direct
    sleep 1s
    scrot $Result_dir/btrfs.png
    cd ..
    umount $2
    echo y | pvcreate $2
    pvdisplay
    scrot $Result_dir/creat1.png
    sleep 1s
    echo y | vgcreate test $2
    vgdisplay
    sleep 1s
    scrot $Result_dir/creat2.png
    echo y | lvcreate -L 1G -n lv1 test
    lvdisplay
    sleep 1s
    scrot $Result_dir/creat3.png
    echo y | lvremove /dev/test/lv1
    echo y | vgremove /dev/test
    echo y | pvremove $2
    sleep 1s
    scrot $Result_dir/delete.png
}
  
function main()
{
    mkdir -p $Result_dir
    #TODO
    sd_test $1 $2
}

main "$@"
