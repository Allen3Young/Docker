FROM nvidia/cuda:10.0-devel-ubuntu18.04
LABEL maintainer="Yuxuan Yang"

ENV CUDNN_VERSION 7.6.4.38
LABEL com.nvidia.cudnn.version="${CUDNN_VERSION}"

# Supress warnings about missing front-end. As recommended at:
# http://stackoverflow.com/questions/22466255/is-it-possibe-to-answer-dialog-questions-when-installing-under-docker
ARG DEBIAN_FRONTEND=noninteractive

# Essentials: developer tools, build tools, OpenBLAS
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils git curl vim unzip openssh-client wget \
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
    numpy scipy sklearn scikit-image imgaug opencv-python IPython[all] matplotlib Cython requests PyYAML h5py
# Install pytorch  
RUN pip3 install https://download.pytorch.org/whl/cu100/torch-1.2.0-cp36-cp36m-manylinux1_x86_64.whl torchvision

RUN apt-get update && apt-get install -y vim python-opengl python3-opengl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# IPython
EXPOSE 8888
