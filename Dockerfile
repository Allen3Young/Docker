FROM nvidia/cuda:10.0-devel-ubuntu18.04
LABEL maintainer="Yuxuan Yang"

ENV CUDNN_VERSION 7.6.4.38
LABEL com.nvidia.cudnn.version="${CUDNN_VERSION}"

# Supress warnings about missing front-end. As recommended at:
# http://stackoverflow.com/questions/22466255/is-it-possibe-to-answer-dialog-questions-when-installing-under-docker
ARG DEBIAN_FRONTEND=noninteractive

# Essentials: developer tools, build tools, OpenBLAS
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils git curl vim unzip openssh-client wget libgtk2.0-dev\
    build-essential cmake \
    libopenblas-dev \
    libcudnn7=$CUDNN_VERSION-1+cuda10.0 \    
    libcudnn7-dev=$CUDNN_VERSION-1+cuda10.0 && \
    apt-mark hold libcudnn7
    

# Python 3.7
# For convenience, alias (but don't sym-link) python & pip to python3 & pip3 as recommended in:
# http://askubuntu.com/questions/351318/changing-symlink-python-to-python3-causes-problems
RUN apt-get install -y --no-install-recommends python3.6 python3.6-dev python3-pip python3-tk && \
    pip3 install --upgrade pip setuptools
# Science libraries and other common packages
RUN pip3 --no-cache-dir install \
    numpy scipy sklearn scikit-image imgaug opencv-python IPython[all] matplotlib Cython requests PyYAML h5py tqdm Pillow==6.2.1

RUN pip3 install jupyter_contrib_nbextensions && jupyter contrib nbextension install 
# Install pytorch  
RUN pip3 install torch===1.4.0+cu100 torchvision===0.5.0+cu100  -f https://download.pytorch.org/whl/torch_stable.html



RUN pip3 install pyquaternion numba kornia numpy-quaternion pymunk progressbar2 tensorboard
RUN apt-get update && apt-get install -y vim python-opengl python3-opengl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888
# VNC Server
EXPOSE 5900
