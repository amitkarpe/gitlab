# gitlab
gitlab on AWS

## Following Sample from [link](https://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html)

## Docker Image Automation for Nextflow

This repository includes automation for pulling Docker images from Docker Hub and pushing them to AWS ECR for use with Nextflow pipelines.

### How it works

1. Add Docker images to `list_images.md` under the "Images" section
2. Create a PR with your changes
3. Once the PR is approved and merged, AWS CodeBuild automatically:
   - Checks if the image already exists in ECR and how recently it was pushed
   - Skips images that were pushed to ECR less than 7 days ago
   - Pulls new or outdated images from Docker Hub
   - Creates ECR repositories if they don't exist
   - Tags the images for ECR
   - Pushes the images to ECR

### Example format for list_images.md

```
mambaorg/micromamba:0.25.1
nextflow/rnaseq-nf:latest
```

### Smart Processing Logic

This automation includes intelligent handling of images:

1. **Efficient Processing**: Only pulls and pushes images when necessary
2. **Age-Based Updates**: By default, images older than 7 days will be refreshed
3. **Error Handling**: Gracefully handles failures and continues processing other images
4. **Authentication**: Uses Docker Hub authentication to avoid rate limiting

### Configuration

The automation uses AWS CodeBuild with the configuration in `buildspec.yml`. The build expects the following environment variables:
- `AWS_DEFAULT_REGION`: AWS region for ECR
- `AWS_ACCOUNT_ID`: AWS account ID
- `DOCKERHUB_USERNAME`: Docker Hub username (to avoid rate limiting)
- `DOCKERHUB_PASSWORD`: Docker Hub password (to avoid rate limiting)
- `MAX_AGE_DAYS`: (Optional) Number of days before refreshing an image (default: 7)

### Local Testing

To test the buildspec.yml logic locally without waiting for AWS CodeBuild:

#### Simple Method (Recommended)
Run the `test-local.sh` script:
```
./test-local.sh
```
This script simulates the buildspec phases and performs actual ECR operations, including checking image age.

#### Full AWS CodeBuild Local Testing
For more comprehensive testing using the AWS CodeBuild Local agent:
```
./local-build.sh
```
This downloads and uses the official AWS CodeBuild Local runner to execute a test build locally.

# Setup Webhook ==> Primary source webhook events 