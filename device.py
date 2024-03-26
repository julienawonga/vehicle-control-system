import boto3
import time
import os

s3_client = boto3.client('s3')
sqs_client = boto3.client('sqs')

def upload_images(bucket_name, image_paths):
    for image_path in image_paths:
        file_name = image_path.split('/')[-1]
        s3_client.upload_file(image_path, bucket_name, file_name)
        print(f"Uploaded {file_name} to {bucket_name}")
        time.sleep(30)

def get_image_paths(directory):
    image_paths = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith(('.jpg', '.jpeg', '.png', '.gif')):
                image_paths.append(os.path.join(root, file))
    return image_paths

image_paths = get_image_paths('path/to/directory')
bucket_name = 'mybucket1234567'
upload_images(bucket_name, image_paths)
