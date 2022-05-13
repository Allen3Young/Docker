#!/bin/bash
#
# Usage:  ./docker_run.sh [/path/to/data]
#
# This script calls `nvidia-docker run` to start the mask-rcnn
# container with an interactive bash session.  This script sets
# the required environment variables and mounts the labelfusion
# source directory as a volume in the docker container.  If the
# path to a data directory is given then the data directory is
# also mounted as a volume.
# 
# -v mount folder into container

image_name=ynyg/torch-gpu-ubuntu20:latest

NOTEBOOKS_PATH=/media/local-data/yuxuan/notebooks
nvidia-docker run --name pytorch_jupyter-ubuntu20 -it --rm -v $NOTEBOOKS_PATH:/notebooks -v /home/ynyg/yuxuan/:/repository \
    --env="DISPLAY" \
    -e NVIDIA_DRIVER_CAPABILITIES=all \
    -e NVIDIA-VISIBLE_DEVICES=all \
    -e QT_X11_NO_MITSHM=1 \ 
    -e NB_UID=1000 -e NB_GID=1000 -e VNC_SERVER_PASSWORD=password -p 8888:8888 --runtime=nvidia \
    --privileged\
    -p 6006:6006 -p 5900:5900 image_name

