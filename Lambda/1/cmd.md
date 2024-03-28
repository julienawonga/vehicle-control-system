# Create the IAM Role with a Trust Relationship for the first lambda function
```bash
aws iam create-role --role-name process-image-role --assume-role-policy-document file://trust-policy.json
```

# Attach Permissions Policies to the Role
```bash
aws iam put-role-policy --role-name process-image-role --policy-name LambdaProcessPolicy --policy-document file://permissions-policy.json
```

```bash
aws lambda update-function-configuration --function-name process-image-function  --role arn:aws:iam::[your-aws-account-id]:role/process-image-role
```