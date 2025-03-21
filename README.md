# gitlab
gitlab on AWS

## Following Sample from [link](https://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html)

## Docker Image Automation for Nextflow

This repository includes automation for pulling Docker images from Docker Hub and pushing them to AWS ECR for use with Nextflow pipelines.

### How it works

1. Add Docker images to `list_images.md` under the "Images" section
2. Create a PR with your changes
3. Once the PR is approved and merged, AWS CodeBuild automatically:
   - Pulls the Docker images from Docker Hub
   - Creates ECR repositories if they don't exist
   - Tags the images for ECR
   - Pushes the images to ECR

### Example format for list_images.md

```
mambaorg/micromamba:0.25.1
nextflow/rnaseq-nf:latest
```

### Configuration

The automation uses AWS CodeBuild with the configuration in `buildspec.yml`. The build expects the following environment variables:
- `AWS_DEFAULT_REGION`: AWS region for ECR
- `AWS_ACCOUNT_ID`: AWS account ID
