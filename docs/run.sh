#!/bin/bash

set -x

# Use default AMI ID if none is provided
if [ -z "$AMI_ID" ]; then
    AMI_ID="ami-01938df366ac2d954"
    echo "No AMI ID provided. Using default AMI ID: $AMI_ID"
else
    echo "Using provided AMI ID: $AMI_ID"
fi

# Check the status of the AMI
AMI_STATUS=$(aws ec2 describe-images --image-ids $AMI_ID --query 'Images[0].State' --output text)

if [ "$AMI_STATUS" == "pending" ]; then
    echo "Error: AMI ID $AMI_ID is in 'pending' state. Cannot launch instance."
    exit 1
elif [ "$AMI_STATUS" != "available" ]; then
    echo "Error: AMI ID $AMI_ID is in an invalid state: $AMI_STATUS"
    exit 1
fi

# Launch the EC2 instance
# aws ec2 run-instances --image-id $AMI_ID --count 1 --instance-type t3.xlarge --key-name amit --security-group-ids sg-0276a736dda5e4a3f sg-01d367382d6cfe56c sg-02828916c4212e616 --subnet-id subnet-0d13ba2dcbb0f6d46 --iam-instance-profile Name=TerraformProductionAccessRole

aws ec2 run-instances --image-id $AMI_ID --count 1 --instance-type t3.xlarge --key-name amit --security-group-ids sg-0276a736dda5e4a3f sg-01d367382d6cfe56c sg-02828916c4212e616 --subnet-id subnet-0d13ba2dcbb0f6d46 --iam-instance-profile Name=TerraformProductionAccessRole --block-device-mappings DeviceName=/dev/xvda,Ebs={VolumeSize=200} --user-data file://user-data.sh

# Check the status of the instance
aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].State.Name' --output text