
# Attach existing role (LabRole) to the existing Lambda function
aws lambda update-function-configuration --function-name process-image-function-s2110849 --role arn:aws:iam::211125692741:role/LabRole

aws lambda update-function-configuration --function-name send-alerte-function-s2110849 --role arn:aws:iam::211125692741:role/LabRole
