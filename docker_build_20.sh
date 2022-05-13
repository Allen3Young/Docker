#!/bin/bash
#
# This script runs docker build to create the pytorch-gpu.
#

set -exu
nvidia-docker build --tag ynyg/torch-gpu-ubuntu20 -f Dockerfile.ubunt20 ./
