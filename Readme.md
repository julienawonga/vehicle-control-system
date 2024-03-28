# Follow Steps in Orders 
<p> Dont forget to replace every where you find [your-aws-account-id] by your AWS Id Account (Remove bracket also), Run the code below to get your aws Account Id </p>

# Retrieve AWS Account Id
```bash
aws sts get-caller-identity --query "Account" --output text
```

# Deploy CloudFormation template
```bash
aws cloudformation deploy --template-file infrastructure.yml  --stack-name infrastructure
```

# You'll discover additional commands within each folder. These commands are located in the ```cmd.md``` file.
