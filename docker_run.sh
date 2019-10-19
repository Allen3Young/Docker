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

image_name=ynyg/torch-gpu:latest

nvidia-docker run --name pytorch -it --rm -v /media/local-data/yuxuan/:/repository -v /home/ynyg/Data/:/repository/Data -p 8888:8888 -p 0.0.0.0:6006:6006 ynyg/torch-gpu:latest /bin/bash
