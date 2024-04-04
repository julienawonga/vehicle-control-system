<#
.SYNOPSIS
This script creates IAM roles and attaches policies to them for AWS Lambda functions. It also runs CloudFormation to create Queues, Lambda functions, and DynamoDB tables.

.DESCRIPTION
The script creates two IAM roles: $roleProcessImageName and $roleSendNotificationName. It then attaches policies to these roles using the AWS CLI command 'aws iam put-role-policy'. Finally, it runs CloudFormation to create Queues, Lambda functions, and DynamoDB tables.

.PARAMETER roleProcessImageName
The name of the IAM role for the 'process-image-function' Lambda function.

.PARAMETER roleSendNotificationName
The name of the IAM role for the 'send-alerte-function' Lambda function.

.EXAMPLE
.\create-roles.ps1
This command runs the script and creates the IAM roles, attaches policies, and runs CloudFormation.

.NOTES
- This script requires the AWS CLI to be installed and configured on the system.
- The trust policy and permissions policy JSON files for each role should be located in the respective directories: 'process-image-function' and 'send-alerte-function'.
- The base directory path should be set in the $baseDir variable.
#>
# Path: lambda/script.ps1

# This script creates IAM roles and attaches policies to them for AWS Lambda functions.
# It also runs CloudFormation to create Queues, Lambda functions, and DynamoDB tables.

$roleProcessImageName = "process-image-role-s2110849"
$roleSendNotificationName = "send-notification-role-s2110849"

$baseDir = "C:\Users\julien\Downloads\coursework\lambda" 

# Create the role
aws iam create-role --role-name $roleProcessImageName --assume-role-policy-document file://$baseDir\process-image-function\trust-policy.json

aws iam create-role --role-name $roleSendNotificationName --assume-role-policy-document file://$baseDir\send-alerte-function\trust-policy.json


# Attach the policy to the role
aws iam put-role-policy --role-name $roleProcessImageName --policy-name LambdaProcessPolicy --policy-document file://$baseDir\process-image-function\permissions-policy.json

aws iam put-role-policy --role-name $roleSendNotificationName --policy-name LambdaNotificationPolicy --policy-document file://$baseDir\send-alerte-function\permissions-policy.json

# Run CloudFormation to create Queues, Lambda functions, DynamoDB tables.

#aws cloudformation create-stack --stack-name infrascture-stack --template-body file://$baseDir\cloudformation.yaml 