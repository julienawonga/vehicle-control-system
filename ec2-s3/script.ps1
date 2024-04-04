<#
.SYNOPSIS
This script creates an IAM role, attaches a policy to the role, creates an instance profile, and adds the role to the instance profile.

.DESCRIPTION
The script performs the following actions:
1. Creates an IAM role named EC2S3AccessRole using the 'create-role' command.
2. Attaches a policy named S3AccessPolicy to the EC2S3AccessRole using the 'put-role-policy' command.
3. Creates an instance profile named EC2Profile using the 'create-instance-profile' command.
4. Adds the EC2S3AccessRole to the EC2Profile using the 'add-role-to-instance-profile' command.

.PARAMETER None
This script does not accept any parameters.

.EXAMPLE
.\script.ps1
Runs the script and performs the actions described in the DESCRIPTION section.

.NOTES
- Ensure that the trust-policy.json and s3-access-policy.json files exist in the current directory.
- This script requires the AWS CLI to be installed and configured with appropriate credentials.
#>

$baseDir = "C:\Users\julien\Downloads\coursework\ec2-s3"

# Create an IAM role named EC2S3AccessRole
aws iam create-role --role-name EC2S3AccessRole --assume-role-policy-document file://$baseDir\trust-policy.json

# Attach a policy named S3AccessPolicy to the EC2S3AccessRole
aws iam put-role-policy --role-name EC2S3AccessRole --policy-name S3AccessPolicy --policy-document file://$baseDir\s3-access-policy.json

# Create an instance profile named EC2Profile
aws iam create-instance-profile --instance-profile-name EC2Profile

# Add the EC2S3AccessRole to the EC2Profile
aws iam add-role-to-instance-profile --instance-profile-name EC2Profile --role-name EC2S3AccessRole

# Run a Python script to create a bucket and get the instance ID
$instance_id = & python.exe $baseDir\create_bucket_ec2.py

# Upload a notification configuration file to an S3 bucket
$bucketName = "store-device-images-s2110849"
aws s3api put-bucket-notification-configuration --bucket $bucketName --notification-configuration file://$baseDir\s3-notification-configuration.json

# Wait for the instance to be in the 'running' state
aws ec2 wait instance-running --instance-ids $instance_id

# Associate the EC2Profile with the instance
aws ec2 associate-iam-instance-profile --instance-id $instance_id --iam-instance-profile Name=EC2Profile
