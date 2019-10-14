#!/bin/bash
#
# This script runs docker build to create the pytorch-gpu.
#

set -exu
sudo nvidia-docker build --tag torch-gpu ./
