import boto3
import base64
import os
def lambda_handler(event, context):
    # Initialize S3 client
    s3_client = boto3.client('s3')

    # The name of your S3 bucket
    bucket_name = os.environ["S3_BUCKET"]

    # Assuming the image is passed as a base64 encoded string in the event
    image_data = base64.b64decode(event['image'])

    # The key under which to store the image in S3
    object_name = 'your-object-name'

    # Upload the image
    s3_client.put_object(Body=image_data, Bucket=bucket_name, Key=object_name)

    return {
        'statusCode': 200,
        'body': 'Image uploaded successfully'
    }
