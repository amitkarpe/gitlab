#!/bin/bash

set -e

# Install s3fs
sudo apt install s3fs -y

# Install NFS server
sudo apt install nfs-kernel-server -y

# Create a directory for S3FS FS shares
mkdir ~/s3-mount

sudo echo user_allow_other | sudo tee -a /etc/fuse.conf

s3fs trust-dev-team ~/s3-mount -o use_cache=/tmp -o allow_other
