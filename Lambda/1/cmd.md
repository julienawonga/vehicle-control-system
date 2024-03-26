# Create the IAM Role with a Trust Relationship for the first lambda function
```bash
aws iam create-role --role-name [name] --assume-role-policy-document file://trust-policy.json
```

# Attach Permissions Policies to the Role
```bash
aws iam put-role-policy --role-name [name] --policy-name ExamplePolicy --policy-document file://permissions-policy.json
```

```bash
aws lambda update-function-configuration --function-name FonctionLambda  --role arn:aws:iam::123456789012:role/role-lambda
```