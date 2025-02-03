#!/bin/bash

aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/l5q9p9n6
docker build -t lifebit/base .
docker tag lifebit/base:latest public.ecr.aws/l5q9p9n6/lifebit/base:latest
docker push public.ecr.aws/l5q9p9n6/lifebit/base:latest
