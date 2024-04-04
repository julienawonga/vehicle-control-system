
# Set the queue policy

$account_id = $account_id = aws sts get-caller-identity --query Account --output text
$queueName = "queue-s2110849"
$region = "us-east-1"
$baseDir = "C:\Users\julien\Downloads\coursework\sqs-queue"

aws sqs set-queue-attributes --queue-url https://sqs.${region}.amazonaws.com/${account_id}/$queueName --attributes file://$baseDir\sqs-policy.json