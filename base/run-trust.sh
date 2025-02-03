#!/bin/bash

aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 590184139818.dkr.ecr.ap-southeast-1.amazonaws.com
docker build -t lifebit/base .
docker tag lifebit/base:latest 590184139818.dkr.ecr.ap-southeast-1.amazonaws.com/lifebit/base:latest
docker push 590184139818.dkr.ecr.ap-southeast-1.amazonaws.com/lifebit/base:latest