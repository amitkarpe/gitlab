#!/bin/bash
# Script to run AWS CodeBuild locally for testing

# Setup environment variables (replace with your values)
export AWS_DEFAULT_REGION="us-east-1"
export AWS_ACCOUNT_ID="123456789012"

# Clone the CodeBuild local agent if needed
if [ ! -d "codebuild-local" ]; then
  echo "Downloading CodeBuild local agent..."
  git clone https://github.com/aws/aws-codebuild-docker-images.git
  cd aws-codebuild-docker-images/local_builds
  ./download_source_build_local.sh
  cd ../..
fi

# Create a test images file with just one image for faster testing
echo "Creating test image list..."
cat > test_images.md <<EOF
# Docker Images for Nextflow Pipelines
## Images
alpine:latest
EOF

# Create a modified buildspec for testing (faster)
cat > test_buildspec.yml <<EOF
version: 0.2

phases:
  pre_build:
    commands:
      - echo "TESTING MODE - No actual ECR login"
      - echo Parsing test_images.md file...
      - IMAGES=\$(grep -v "^#" test_images.md | grep -v "^$" | grep -v "^\`\`\`" | grep -v "^image_name" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
  
  build:
    commands:
      - echo Build started on \`date\`
      - echo Processing Docker images...
      - |
        for IMAGE in \$IMAGES; do
          if [[ \$IMAGE == *":"* ]]; then
            IMAGE_NAME=\$(echo \$IMAGE | cut -d: -f1)
            IMAGE_TAG=\$(echo \$IMAGE | cut -d: -f2)
          else
            IMAGE_NAME=\$IMAGE
            IMAGE_TAG="latest"
          fi
          
          echo "Processing \$IMAGE_NAME:\$IMAGE_TAG"
          
          # Pull the image from Docker Hub - we still do this part for real
          echo "Pulling \$IMAGE_NAME:\$IMAGE_TAG from Docker Hub"
          docker pull \$IMAGE_NAME:\$IMAGE_TAG
          
          # Mock ECR operations
          echo "WOULD CREATE REPOSITORY: \$IMAGE_NAME (if needed)"
          echo "WOULD TAG: \$IMAGE_NAME:\$IMAGE_TAG as \$AWS_ACCOUNT_ID.dkr.ecr.\$AWS_DEFAULT_REGION.amazonaws.com/\$IMAGE_NAME:\$IMAGE_TAG"
          echo "WOULD PUSH: \$AWS_ACCOUNT_ID.dkr.ecr.\$AWS_DEFAULT_REGION.amazonaws.com/\$IMAGE_NAME:\$IMAGE_TAG"
        done
  
  post_build:
    commands:
      - echo Docker image processing completed on \`date\`
      - echo "All images in test_images.md have been processed"

artifacts:
  files:
    - test_images.md
    - test_buildspec.yml
EOF

# Run the build locally
echo "Running local CodeBuild..."
cd aws-codebuild-docker-images/local_builds
./run_local.sh -i amazon/aws-codebuild-local:latest -a ../.. -b ../test_buildspec.yml 