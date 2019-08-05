#!/usr/bin/bash
#set -e

#git submodule init
#git submodule update


VOLANTMQ_WORK_DIR="${PWD}/bin"
VOLANTMQ_BUILD_FLAGS="-i"
VOLANTMQ_PLUGINS_DIR="${PWD}/bin/plugins"

mkdir -p $VOLANTMQ_WORK_DIR/bin
mkdir -p $VOLANTMQ_WORK_DIR/conf
mkdir -p $VOLANTMQ_PLUGINS_DIR


export GO15VENDOREXPERIMENT=1
export GOBIN=${PWD}/bin
#export GOPATH=${PWD}/gopath
export GOOS=linux
export PATH=$PATH:$GOBIN



FMT="."
echo "Checking gofmt..."
fmtRes=$(gofmt -l $FMT)
if [ -n "${fmtRes}" ]; then
    echo -e "gofmt checking failed:\n${fmtRes}"
    #exit 255
fi

echo "Building volantmq"
cd $GOPATH/src/github.com/ahmetb/govvv
go install
cd $GOPATH/src/github.com/VolantMQ/volantmq
govvv build $VOLANTMQ_BUILD_FLAGS -o $VOLANTMQ_WORK_DIR/volantmq
echo "Building volantmq ok"
cd $GOPATH/src/github.com/VolantMQ/vlapi/plugin/debug
go build $VOLANTMQ_BUILD_FLAGS -buildmode=plugin -o $VOLANTMQ_WORK_DIR/plugins/debug.so
cd  $GOPATH/src/github.com/VolantMQ/vlapi/plugin/health
go build $VOLANTMQ_BUILD_FLAGS -buildmode=plugin -o $VOLANTMQ_WORK_DIR/plugins/health.so
cd $GOPATH/src/github.com/VolantMQ/vlapi/plugin/persistence/bbolt/plugin
go build $VOLANTMQ_BUILD_FLAGS -buildmode=plugin -o $VOLANTMQ_WORK_DIR/plugins/persistence_bbolt.so
echo "Building volantmq plugins ok"
#GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -ldflags "-X hobot.cc/iot/useradm.Tag=`git describe --abbrev=0 --tags`" -o bin/useradm hobot.cc/iot/useradm/cmd
#cp cmd/useradm bin/
#cp Dockerfile bin/
#cp config.yaml conf/
#docker build -t iot_mqtt .

