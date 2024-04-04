<#
.SYNOPSIS
Creates an S3 bucket and copies zip files to the bucket.

.DESCRIPTION
This script creates an S3 bucket and copies zip files to the bucket. It uses the AWS CLI (Command Line Interface) to interact with AWS S3.

.PARAMETER bucketName
The name of the S3 bucket to be created.

.PARAMETER baseDir
The base directory where the zip files are located.

.EXAMPLE
.\create-bucket.ps1 -bucketName "zipstorefunctions-s2110849" -baseDir "C:\Users\julien\Downloads\coursework\lambda"

This example creates an S3 bucket named "zipstorefunctions-s2110849" and copies the zip files from the base directory "C:\Users\julien\Downloads\coursework\lambda" to the bucket.

.NOTES
- Make sure you have the AWS CLI installed and configured with valid credentials before running this script.
- The AWS CLI commands "aws s3 mb" and "aws s3 cp" are used to create the bucket and copy files respectively.
#>
$bucketName = "zipstorefunctions-s2110849"

$baseDir = "C:\Users\julien\Downloads\coursework\lambda"

# Create the bucket
aws s3 mb s3://$bucketName

# Copy the zip files to the bucket
aws s3 cp $baseDir\process-image-function\process-image-function-s2110849.zip s3://$bucketName/
aws s3 cp $baseDir\send-alerte-function\send-alerte-function-s2110849.zip s3://$bucketName/