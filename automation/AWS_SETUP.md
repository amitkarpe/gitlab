# AWS CodeBuild Setup for Docker Image Automation

This document explains how to set up AWS CodeBuild to automate pulling Docker images and pushing them to AWS ECR.

## Prerequisites

1. AWS Account with access to ECR and CodeBuild
2. IAM permissions to create and manage CodeBuild projects
3. IAM permissions to push to ECR

## Setting up the CodeBuild Project

1. Go to AWS CodeBuild in the AWS Console

2. Click "Create build project" and enter the following details:
   - Project name: `gitlab-ecr-docker-sync` (match the name in .gitlab-ci.yml)
   - Source Provider: GitLab
   - Repository: Connect to your GitLab instance and select this repository
   - Environment:
     - Managed image: Amazon Linux 2 or Ubuntu
     - Privileged: **Yes** (Required for Docker commands)
   - Service role: Create a new service role or use an existing one with ECR permissions
   - Buildspec: Use the buildspec.yml in the repository

3. Add the following environment variables:
   - `AWS_DEFAULT_REGION`: The AWS region where your ECR repository is located
   - `AWS_ACCOUNT_ID`: Your AWS account ID

## IAM Permissions Required

The CodeBuild service role needs the following permissions:
- ECR:CreateRepository
- ECR:DescribeRepositories
- ECR:PutImage
- ECR:InitiateLayerUpload
- ECR:UploadLayerPart
- ECR:CompleteLayerUpload
- ECR:BatchCheckLayerAvailability
- ECR:GetAuthorizationToken

## GitLab CI Integration

The `.gitlab-ci.yml` file is configured to trigger the CodeBuild project whenever changes are merged to the main branch.

To enable this integration:

1. Create an IAM user with the following permissions:
   - codebuild:StartBuild
   - codebuild:BatchGetBuilds

2. Generate access and secret keys for this user

3. Add the following CI/CD variables in your GitLab project:
   - AWS_ACCESS_KEY_ID: The IAM user's access key
   - AWS_SECRET_ACCESS_KEY: The IAM user's secret key
   - AWS_DEFAULT_REGION: The AWS region where CodeBuild is located 


## Enable "Primary source webhook events"