import boto3
import base64
import json
import random 
import os
def lambda_handler(event, context):
    s3_client = boto3.client('s3')
    body = body = json.loads(event['body'])
    print(body)
    bucket_name = os.environ["S3_BUCKET"]

    image_data = base64.b64decode(body['image'])

    object_name = str(random.randint(0,10000))+'.jpg'

    s3_client.put_object(Body=image_data, Bucket=bucket_name, Key=object_name)

    return {
        'statusCode': 200,
        'body': json.dumps({
            "name": object_name,
            "message": "Upload image successfully!"
        })
    }
