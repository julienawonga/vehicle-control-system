```bash
aws iam create-policy --policy-name S3AccessPolicy --policy-document file://s3-access-policy.json
```
```bash
aws iam create-role --role-name EC2S3AccessRole --assume-role-policy-document file://trust-policy.json
```

```bash
aws iam create-instance-profile --instance-profile-name Profile
```
```bash
aws iam add-role-to-instance-profile --instance-profile-name Profile --role-name Role
```

```bash
aws ec2 associate-iam-instance-profile --instance-id i-0123456789abcdef0 --iam-instance-profile Name=Profile
```