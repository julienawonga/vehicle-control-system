import boto3

s3_client = boto3.client('s3')
ec2_resource = boto3.resource('ec2')

def create_bucket(bucket_name):
    s3_client.create_bucket(Bucket=bucket_name)
    print(f"Bucket {bucket_name} created.")



def create_ec2_instance(image_id, instance_type, key_name):
    user_data_script = """
    #!/bin/bash
    yum update -y
    yum install git -y
    yum install unzip -y
    cd /home/ec2-user
    
    # Clone code Python
    git clone https://github.com/julienawonga/device-coursew

    # Move to code directory
    cd device-coursew
    
    # Unzip images
    unzip images.zip 
    
    
    python3 device.py /home/ec2-user/device-coursew/images/
    """

    instance = ec2_resource.create_instances(
        ImageId=image_id,
        InstanceType=instance_type,
        KeyName=key_name,
        MinCount=1,
        MaxCount=1,
        UserData=user_data_script,
    )
    print(f"EC2 Instance {instance[0].id} created.")

    


if __name__ == '__main__':

    bucket_name = 'store-device-images' 

    create_bucket(bucket_name)

    create_ec2_instance('ami-0bd01824d64912730', 't2.micro', 'my-key-pair') 
