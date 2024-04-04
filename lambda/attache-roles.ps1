<#
.SYNOPSIS
This script attaches roles to the lambda functions.

.DESCRIPTION
The script retrieves the AWS account ID and uses it to update the configuration of two lambda functions: 'process-image-function-s2110849' and 'send-notification-function-s2110849'. It assigns the appropriate IAM roles to each function.

.PARAMETER account_id
The AWS account ID.

.PARAMETER processImageFunctionName
The name of the lambda function for processing images.

.PARAMETER sendNotificationFunctionName
The name of the lambda function for sending notifications.

.EXAMPLE
.\attache-roles.ps1
This command runs the script and attaches the roles to the lambda functions.

.NOTES
Author: [Your Name]
Date: [Current Date]
#>
# Description: This script attaches the roles to the lambda functions

$account_id = aws sts get-caller-identity --query Account --output text

$processImageFunctionName = "process-image-function-s2110849"
$sendNotificationFunctionName = "send-notification-function-s2110849"

aws lambda update-function-configuration --function-name $processImageFunctionName  --role arn:aws:iam::${account_id}:role/process-image-role-s2110849

aws lambda update-function-configuration --function-name $sendNotificationFunctionName  --role arn:aws:iam::${account_id}:role/send-notification-role-s2110849