#!/bin/bash
##### CONFIGS #####
HOST_VOLUME="/Users/coldblaze/docker_works"
CONTAINER_MNT="/srv"
NAME="pyqt5-korean"
HOST_NAME="pyqt5-korean"
NETWORK_CARD="en1"
HOST_PORT="10022"
CONTAINER_PORT="22"
##### END OF CONFIGS #####

_IMAGE="coldblaze/pyqt5-korean"
_IMAGE_TAG="latest"

case $1 in
pull)
   docker pull $_IMAGE:$_IMAGE_TAG
   ;;
run)
    echo ${0##$}" run"
    # For macOS with socat
    case "$OSTYPE" in
    darwin*)
        _MY_IP=`ipconfig getifaddr $NETWORK_CARD`
        
        docker run \
        --interactive --tty \
        --rm \
        --hostname $HOST_NAME --name $NAME \
        --publish $HOST_PORT:$CONTAINER_PORT \
        --volume $HOST_VOLUME:$CONTAINER_MNT:rw \
        --env DISPLAY=$_MY_IP:0 \
        $_IMAGE:$_IMAGE_TAG
    ;;
    linux*)
        xhost +local:
        docker run \
        --interactive --tty \
        --rm \
        --hostname $HOST_NAME --name $NAME \
        --publish $HOST_PORT:$CONTAINER_PORT \
        --volume $HOST_VOLUME:$CONTAINER_MNT:rw \
        --volume /tmp/.X11-unix:/tmp/.X11-unix:rw \
        --env DISPLAY=unix$DISPLAY \
        $_IMAGE:$_IMAGE_TAG
    ;;
    esac
;;
stop)
    echo ${0##$}" stop"
    docker stop $NAME
    docker rm $NAME
;; 
*)
    echo "Usage: ./"${0##*/}" [run|stop]"
;;
esac
