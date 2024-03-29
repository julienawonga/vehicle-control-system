#!/bin/bash

# Get the AWS account id
aws_account_id=$(aws sts get-caller-identity --query Account --output text)

# Set the AWS account id as an environment variable
export AWS_ACCOUNT_ID=$aws_account_id

# Switch to the root user (Amazon Linux)
sudo su

# Update the system (Amazon Linux)
sudo yum update -y

# Install the git package
sudo yum install git -y

# Install Python 
sudo yum install python3 -y

# Install boto3
pip3 install boto3

# Clone the repository
git clone https://github.com/julienawonga/course-work

# Move to the repository
cd course-work

# Setpe 0 : Create ses domain verification
aws sesv2 create-email-identity --email-identity megane.farelle@gmail.com

# Step 1: Create Buckets to store lambda functions zipped files
aws s3 mb s3://lambda-functions-zipped-files 

# Upload the zipped files to the bucket
aws s3 cp lambda/1/lambda_handler.zip s3://lambda-functions-zipped-files/

aws s3 cp lambda/2/lambda_handler2.zip s3://lambda-functions-zipped-files/

# Step 2: Create roles and policies for the lambda functions

# Create the role for the first lambda function
aws iam create-role --role-name process-image-role --assume-role-policy-document file://lambda/1/trust-policy.json
aws iam put-role-policy --role-name process-image-role --policy-name LambdaProcessPolicy --policy-document file://lambda/1/permissions-policy.json

# Create the role for the second lambda function
aws iam create-role --role-name send-notification-role --assume-role-policy-document file://lambda/2/trust-policy.json
aws iam put-role-policy --role-name send-notification-role --policy-name LambdaSendNotificationPolicy --policy-document file://lambda/2/permissions-policy.json

# Step 3: Deploy cloudformation stack
aws cloudformation deploy --template-file infrastructure.yml  --stack-name infrastructure

# Step 4: Assign Role to the lambda functions
aws lambda update-function-configuration --function-name process-image-function  --role arn:aws:iam::$AWS_ACCOUNT_ID:role/process-image-role
aws lambda update-function-configuration --function-name send-notification-function  --role arn:aws:iam::$AWS_ACCOUNT_ID:role/send-notification-role

# Step 5: Configure sqs policy
aws sqs set-queue-attributes --queue-url https://sqs.us-east-1.amazonaws.com/$AWS_ACCOUNT_ID/queue1234567 --attributes file://sqs/sqs-policy.json

# Step 4: Assign Role to the lambda functions
aws lambda update-function-configuration --function-name process-image-function  --role arn:aws:iam::$AWS_ACCOUNT_ID:role/process-image-role
aws lambda update-function-configuration --function-name send-notification-function  --role arn:aws:iam::$AWS_ACCOUNT_ID:role/send-notification-role

# Step 5: Configure sqs policy
aws sqs set-queue-attributes --queue-url https://sqs.us-east-1.amazonaws.com/$AWS_ACCOUNT_ID/queue1234567 --attributes file://sqs/sqs-policy.json

# Step 6: Run (create_bucket_ec2.py) and get the instance id
instance_id=$(python3 create_bucket_ec2.py)

# Step 7: Assign role to the bucket
aws s3api put-bucket-notification-configuration --bucket store-device-images --notification-configuration file://s3/s3-notification-configuration.json

# Step 6 : Assign role to the instance
aws iam create-role --role-name EC2S3AccessRole --assume-role-policy-document file://ec2/trust-policy.json
aws iam put-role-policy --role-name EC2S3AccessRole --policy-name S3AccessPolicy --policy-document file://ec2/s3-access-policy.json
aws iam create-instance-profile --instance-profile-name EC2Profile
aws iam add-role-to-instance-profile --instance-profile-name EC2Profile --role-name EC2S3AccessRole
aws ec2 associate-iam-instance-profile --instance-id $instance_id --iam-instance-profile Name=EC2Profile