aws sns create-topic --name sendMailTopic

aws sns subscribe --topic-arn arn:aws:sns:us-east-1:211125692741:sendMailTopic --protocol email --notification-endpoint julienawon@yahoo.com

aws sns publish --topic-arn arn:aws:sns:us-east-1:211125692741:sendMailTopic --message "Test message from Amazon SNS via CLI"
