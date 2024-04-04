import boto3

def add_vehicle(table_name, vehicle_id, status):
    # Ensure that status is either 'blacklisted' or 'whitelisted'
    if status not in ['blacklisted', 'whitelisted']:
        print("Invalid status. Please use 'blacklisted' or 'whitelisted'.")
        return

    # Create a DynamoDB client using boto3
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table(table_name)

    # Put item in the table
    response = table.put_item(
        Item={
            'VehicleID': vehicle_id,
            'Status': status,
        }
    )

if __name__ == '__main__':

    table_name = 'VehicleTable-s2110849'
    add_vehicle(table_name, '10652 OC 22', 'blacklisted')
    add_vehicle(table_name, '8740 NV 12', 'blacklisted')
