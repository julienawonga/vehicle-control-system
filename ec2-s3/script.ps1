
$baseDir = "C:\Users\julien\Downloads\coursework\ec2-s3"


# Run a Python script to create a bucket and get the instance ID
$instance_id = & python.exe $baseDir\create_bucket_ec2.py

# Upload a notification configuration file to an S3 bucket
$bucketName = "store-device-images-s2110849"
aws s3api put-bucket-notification-configuration --bucket $bucketName --notification-configuration file://$baseDir\s3-notification-configuration.json

# Wait for the instance to be in the 'running' state
aws ec2 wait instance-running --instance-ids $instance_id

# Associate the EC2Profile with the instance
aws ec2 associate-iam-instance-profile --instance-id $instance_id --iam-instance-profile Name=LabInstanceProfile
