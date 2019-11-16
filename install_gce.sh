#!/bin/bash

# Gather CTRL and copy to working directory
git clone https://github.com/salesforce/ctrl.git
mv ctrl/* .

# Install Tensorflow-GPU :) 
sudo pip2 install tensorflow-gpu==1.14 

# Cython is needed to compile fastBPE
sudo pip2 install Cython
# For own own script we need PythonMysql. 
sudo pip2 install mysql-connector-python

# Patch the TensorFlow estimator package
sudo patch -b /usr/local/lib/python2.7/dist-packages/tensorflow_estimator/python/estimator/keras.py estimator.patch

# Install fastBPE
sudo pip2 install fastBPE

# Download the 512-length model if specified, 256-length otherwise
if [ "$1" = "512" ]
then
    URL="gs://sf-ctrl/seqlen512_v1.ckpt/"
else
    URL="gs://sf-ctrl/seqlen256_v0.ckpt/"
fi

# Copy model
gsutil -m cp -r "$URL" .
