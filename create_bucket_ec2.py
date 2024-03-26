import boto3

s3_client = boto3.client('s3')
ec2_resource = boto3.resource('ec2')

user_data_script = """#!/bin/bash
yum update -y
yum install python3 -y
pip3 install boto3
"""

def create_bucket(bucket_name):
    s3_client.create_bucket(Bucket=bucket_name)
    print(f"Bucket {bucket_name} created.")



def create_ec2_instance(image_id, instance_type, key_name):
    instance = ec2_resource.create_instances(
        ImageId=image_id,
        InstanceType=instance_type,
        KeyName=key_name,
        UserData=user_data_script,
        MinCount=1,
        MaxCount=1,
    )
    print(f"EC2 Instance {instance[0].id} created.")
    


if __name__ == '__main__':

    bucket_name = 'mybucket1234567' 

    create_bucket(bucket_name)

    create_ec2_instance('ami-12345', 't2.micro', 'my-key-pair') 
