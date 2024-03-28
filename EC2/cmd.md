```bash
aws iam create-role --role-name EC2S3AccessRole --assume-role-policy-document file://trust-policy.json
```
```bash
aws iam put-role-policy --role-name EC2S3AccessRole --policy-name S3AccessPolicy --policy-document file://s3-access-policy.json
```

```bash
aws iam create-instance-profile --instance-profile-name EC2Profile
```
```bash
aws iam add-role-to-instance-profile --instance-profile-name EC2Profile --role-name EC2S3AccessRole
```

```bash
aws ec2 associate-iam-instance-profile --instance-id i-0dc11373b3beaf0c2 --iam-instance-profile Name=EC2Profile
```