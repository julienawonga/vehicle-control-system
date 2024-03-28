import boto3
import json
from botocore.exceptions import ClientError

# Initialize the AWS SES client
ses_client = boto3.client('ses')

# Define the email details
SENDER_EMAIL = 'Megane Farelle <megane.farelle@gmail.com>'  
RECIPIENT_EMAIL = 'megane.farelle@gmail.com' 
SUBJECT = 'Security Alert: Action Required'
CHARSET = 'UTF-8'

def send_email(recipient, subject, body_text):
    try:
        response = ses_client.send_email(
            Destination={
                'ToAddresses': [recipient]
            },
            Message={
                'Body': {
                    'Text': {
                        'Charset': CHARSET,
                        'Data': body_text
                    },
                },
                'Subject': {
                    'Charset': CHARSET,
                    'Data': subject,
                },
            },
            Source=SENDER_EMAIL,
        )
    except ClientError as e:
        print(f"An error occurred: {e.response['Error']['Message']}")
    else:
        print(f"Email sent! Message ID: {response['MessageId']}")

def lambda_handler(event, context):
    # Process each record from the DynamoDB stream
    for record in event['Records']:
        if record['eventName'] == 'INSERT':  # Check for new entries only
            new_image = record['dynamodb']['NewImage']
            
            # Extract the relevant information from the new DynamoDB entry
            image_name = new_image['ImageName']['S']
            detected_texts = json.loads(new_image['DetectedTexts']['S'])
            detected_labels = json.loads(new_image['DetectedLabels']['S'])

            # Determine if an action is needed based on the detected text or labels
            # For demonstration purposes, let's assume we check for a "Blacklisted" label
            blacklisted = any(label['Name'] == 'Blacklisted' for label in detected_labels)
            
            # If conditions are met, send an email notification
            if blacklisted:
                email_body = (
                    f"A blacklisted vehicle has been detected in the image: {image_name}\n"
                    f"Detected Texts: {detected_texts}\n"
                    f"Detected Labels: {detected_labels}"
                )
                send_email(RECIPIENT_EMAIL, SUBJECT, email_body)
                print(f"Alert sent for image: {image_name}")
            else:
                email_body = (
                    f"A blacklisted vehicle has been detected in the image: {image_name}\n"
                    f"Detected Texts: {detected_texts}\n"
                    f"Detected Labels: {detected_labels}"
                )
                send_email(RECIPIENT_EMAIL, SUBJECT, email_body)
                print(f"Alert sent for image: {image_name}")
    
    # Return a success response
    return {'statusCode': 200, 'body': json.dumps('Email notification processing completed successfully.')}

