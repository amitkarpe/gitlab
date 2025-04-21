#!/bin/bash

set -x

# Check for command-line arguments
AMI_NAME=$1
AMI_ID=$2

if [ -z "$AMI_ID" ]; then
    if [ -z "$AMI_NAME" ]; then
        echo "Error: AMI name must be provided if AMI ID is not specified."
        exit 1
    fi

    echo "Creating image with name: $AMI_NAME"
    IMAGE_ID=$(aws ec2 create-image --instance-id i-05ae2eba3e0b09b5a --name "$AMI_NAME" --no-reboot --query 'ImageId' --output text 2>&1)

    # Check if the create-image command was successful
    if [[ $IMAGE_ID == *"InvalidAMIName.Duplicate"* ]]; then
        echo "Error: AMI name '$AMI_NAME' is already in use."
        exit 1
    elif [[ $IMAGE_ID == *"An error occurred"* ]]; then
        echo "Error creating image: $IMAGE_ID"
        exit 1
    fi

    echo "Image created: $IMAGE_ID"
else
    IMAGE_ID=$AMI_ID
    echo "Using provided AMI ID: $IMAGE_ID"
fi

# Check the status of the image
while true; do
    IMAGE_STATUS=$(aws ec2 describe-images --image-ids $IMAGE_ID --query 'Images[0].State' --output text)
    echo "Current image status: $IMAGE_STATUS"
    
    if [ "$IMAGE_STATUS" == "available" ]; then
        echo "Image is ready."
        break
    elif [ "$IMAGE_STATUS" == "failed" ]; then
        echo "Image creation failed."
        exit 1
    else
        echo "Image is still pending. Waiting for 5 minutes before checking again..."
        sleep 300  # Wait for 5 minutes
    fi
done

echo "Creating instance"

aws ec2 run-instances --image-id $IMAGE_ID --count 1 --instance-type t3.xlarge --key-name amit --security-group-ids sg-0276a736dda5e4a3f sg-01d367382d6cfe56c sg-02828916c4212e616 --subnet-id subnet-0d13ba2dcbb0f6d46 --iam-instance-profile Name=TerraformProductionAccessRole

