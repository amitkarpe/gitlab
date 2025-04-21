#! /bin/bash
# https://maxulysse.github.io/2021/04/13/nf-core_offline-index/#/11
# https://eqtlgen.github.io/eqtlgen-web-site/eQTLGen-p2-offline-instructions.html

# On Server

# nf-core pipelines download sarek -r 3.5.1 --force --container-cache-utilisation copy -s singularity --parallel-downloads 10 --outdir outdir-sarek_3.5.1 -x none
# 
# On Client
echo "Copy AWS Credentials"

# https://github.com/amitkarpe/setup/blob/main/scripts/ubuntu.sh

sudo apt update -y
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y


pip3 install awscli --upgrade --user --break-system-packages
aws sts get-caller-identity

echo "Check all files at /home/ubuntu/s3-mount"
ls -la /home/ubuntu/s3-mount

echo "Check all files at /home/ubuntu/s3-mount/trust-dev-team/gitlab/singularity"
ls -la /home/ubuntu/s3-mount/trust-dev-team/gitlab/singularity

rsync -vpr  /home/ubuntu/s3-mount/gitlab/pipe/sarek  ~/sarek
export NXF_OFFLINE='true'
# Download samplesheet

wget https://github.com/nf-core/sarek/blob/3.5.1/assets/samplesheet.csv -O /tmp/samplesheet.csv 

# Install podman buildah skopeo
sudo apt install -y podman buildah skopeo docker-ce

# Add user to docker group
sudo usermod -aG docker $USER
sudo systemctl status docker
sudo docker run hello-world