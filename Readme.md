# Vehicle Control System with AWS AI Services 

A cloud-based security application designed to monitor and control vehicle entry at security checkpoints. This project uses AWS Rekognition for image analysis and license plate detection, alongside automated workflows for a seamless and secure experience.

![architecture](https://github.com/user-attachments/assets/a3ff7523-8300-415b-ae0e-e3bf266c44ad)

## Table of Contents
- [Project Overview](#project-overview)
- [Architecture](#architecture)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Setup Instructions](#setup-instructions)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Project Overview
This application simulates a security system that uses a camera to capture images of vehicles at an entry point. These images are processed on AWS to identify vehicle types and read license plates, automating security responses such as logging entry attempts and alerting personnel for flagged vehicles.

## Architecture
The application architecture includes:
1. **EC2 Instance**: Simulates a camera system, periodically uploading images to an S3 bucket.
2. **S3 Bucket**: Stores vehicle images for processing.
3. **SQS Queue and Lambda**: Automates processing; SQS triggers a Lambda function each time an image is uploaded.
4. **AWS Rekognition**: Performs label and text (license plate) detection on vehicle images.
5. **DynamoDB**: Maintains records of vehicles, storing detected data and vehicle statuses.
6. **Notification System**: Sends email alerts for blacklisted or unregistered vehicles.

## Features
- **Automated Image Analysis**: Detects vehicle type and license plates with AWS Rekognition.
- **Real-time Data Storage**: Updates DynamoDB with vehicle information.
- **Automated Alerts**: Sends notifications to security personnel for flagged vehicles.
- **Infrastructure as Code**: Resources are provisioned automatically using CloudFormation templates.

## Technologies Used
- **AWS Services**: EC2, S3, SQS, Lambda, Rekognition, DynamoDB
- **CloudFormation**: Automates setup of AWS resources
- **Python (Boto3)**: Used for scripting and AWS SDK interactions

## Setup Instructions
1. **Clone the Repository**:
    ```bash
    git clone https://github.com/julienawonga/vehicle-control-system.git
    cd vehicle-control-system
    ```
2. **Set Up AWS Resources**:
   - Use the provided CloudFormation templates to create required AWS resources.
3. **Configure IAM Roles and Policies**:
   - Ensure your IAM roles have permissions for EC2, S3, Lambda, Rekognition, and DynamoDB.
4. **Run the Application**:
   - Use the Python scripts to initiate the EC2 instance and begin uploading images to S3.

## Usage
- **Image Processing**: Upload images to the S3 bucket to trigger the detection workflow.
- **Data Logging**: Vehicle information is stored in DynamoDB.
- **Alert System**: Notifications are sent for unrecognized or blacklisted vehicles.

## Contributing
Feel free to open issues or submit pull requests. Contributions to improve the system or add new features are always welcome!

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.

---
