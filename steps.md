1. Create buckets to store the lambda code
2. Create roles and policies for the lambda functions
3. Run cloudformation to create the lambda functions, api SQS , dynamodb table .
4. Populate the dynamodb table (VehicleTable) with data (populate_data.py)
4. Attach roles to the lambda functions
5. Attache policies to S3 bucket (for sqs event notification)
6. Attache policies to SQS (for s3 event notification)
7. Run script in ec2-s3 