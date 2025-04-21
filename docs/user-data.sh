#!/bin/bash

# Enable error handling
set -e

# Update package list
sudo apt update

# Install Java (required for Nextflow)
sudo apt install -y openjdk-21-jre

# Install Nextflow
curl -s https://get.nextflow.io | bash
sudo mv nextflow /usr/local/bin/

# Verify Nextflow installation
nextflow -v

# Install nf-core tools
sudo apt install python3-pip -y
pip install nf-core --break-system-packages

# Verify nf-core installation
nf-core --version

# Install Apptainer (formerly Singularity)
cd /tmp/
wget https://github.com/apptainer/apptainer/releases/download/v1.4.0/apptainer_1.4.0_amd64.deb
sudo apt install -y ./apptainer_1.4.0_amd64.deb

# Verify Apptainer installation
apptainer --version

# Install s3fs
sudo apt install -y s3fs

# Install NFS server
sudo apt install -y nfs-kernel-server

# Create a directory for S3FS FS shares
mkdir ~/s3-mount

# Allow other users to access the mounted file system
echo user_allow_other | sudo tee -a /etc/fuse.conf

# Mount the S3 bucket
s3fs trust-dev-team ~/s3-mount -o use_cache=/tmp -o allow_other

echo "Installation and setup of nf-core, Nextflow, Apptainer, and NFS are complete."
