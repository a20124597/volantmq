#!/usr/bin/bash
set -e

WORK_DIR=`dirname $0`
if [ "$WORK_DIR" = "." ];then
    WORK_DIR=$PWD
fi

export PATH=$PATH:${WORK_DIR}/bin

cd $WORK_DIR
./bin/volantmq -config "./conf/config.yaml" -plugins-dir "./bin/plugins" -work-dir "./bin"

