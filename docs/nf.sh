#!/bin/bash

set -e

# Update package list
sudo apt update

# Install Java (required for Nextflow)
# sudo apt install -y openjdk-11-jre
# Install Java 17
sudo apt install -y openjdk-21-jre
#udo update-alternatives --config java

# Install Nextflow
curl -s https://get.nextflow.io | bash
sudo mv nextflow /usr/local/bin/

# Verify Nextflow installation
nextflow -v

# Install nf-core tools
sudo apt install python3-pip -y
pip install nf-core  --break-system-packages

# Verify nf-core installation
nf-core --version

# Install Apptainer (formerly Singularity)
cd /tmp/
wget https://github.com/apptainer/apptainer/releases/download/v1.4.0/apptainer_1.4.0_amd64.deb
sudo apt install -y ./apptainer_1.4.0_amd64.deb

# Verify Apptainer installation
apptainer --version

echo "Installation of nf-core, Nextflow, and Apptainer is complete."

