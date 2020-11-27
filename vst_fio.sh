#!/bin/bash

#脚本功能

#输入参数     /dev/sdX 为待测盘

RESULT_DIR='/home/test/Desktop/fio'

function do_fio_test()

{
   
    local filename=$1 #第一个参数
    echo y | mkfs.ext4 $1
    fio -filename=$1 -ioengine=libaio -time_based=1 -rw=write -direct=1  -thread -size=32g -bs=128k -numjobs=1 -iodepth=32 -runtime=60  -group_reporting -name="cepreiTest-IOwrite" >$RESULT_DIR/128K_read.log
    
    echo y | mkfs.ext4 $1
    fio -filename=$1 -ioengine=libaio -time_based=1 -rw=read -direct=1  -thread -size=32g -bs=128k -numjobs=1 -iodepth=32 -runtime=60  -group_reporting -name="cepreiTest-IOread"  >$RESULT_DIR/128K_write.log
    
    echo y | mkfs.ext4 $1
    fio -filename=$1 -ioengine=libaio -time_based=1 -rw=randwrite -direct=1  -thread -size=32g -bs=4k -numjobs=1 -iodepth=32 -runtime=60  -group_reporting -name="cepreiTest-IOrandwrite" >$RESULT_DIR/4K_read.log
    
    echo y | mkfs.ext4 $1
    fio -filename=$1 -ioengine=libaio -time_based=1 -rw=randread -direct=1  -thread -size=32g -bs=4k -numjobs=1 -iodepth=32 -runtime=60  -group_reporting -name="cepreiTest-IOrandread">$RESULT_DIR/4K_write.log.log
}

main(){

mkdir -p $RESULT_DIR

#TODO
do_fio_test $1

# 每次跑之前清理之前的结果
find $RESULT_DIR -maxdepth 1 -type f -name "fio*.log" -exec rm -f {} \;
}

main "$@"
