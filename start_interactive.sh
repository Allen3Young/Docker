#!/bin/bash

if [ -z $1 ];
        then
        echo "You must provide a docker volume to mount as argument";
        exit;
fi

USER=`whoami`
echo $USER

nvidia-docker run -it --rm --name ynyg_pytorch -v /home/ynyg/:/repository -v $1:/mnt/data --privileged --cap-add=SYS_ADMIN --label user=$USER --runtime=nvidia ynyg/torch-gpu:latest bash 

