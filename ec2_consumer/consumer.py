from json import loads
import json
import os

from kafka import KafkaConsumer
import boto3

TOPIC_NAME = os.environ["TOPIC_NAME"]
SERVER_PORT = os.environ["SERVER_PORT"]
BUCKET_NAME = os.environ["BUCKET_NAME"]
SYMBOL = os.environ["SYMBOL"]

s3 = boto3.client('s3')
consumer = KafkaConsumer(TOPIC_NAME,
                         bootstrap_servers=[SERVER_PORT], 
                         value_deserializer=lambda x: loads(x.decode('utf-8')),
                         api_version=(0,10,2))

# this needs to be fixed to write to s3 bucket
for count,c in enumerate(consumer):
    data = c.value
    print(data)
    json_data = json.dumps(data)
    key_name = f"{SYMBOL}_tick_data_{count}.json"
    s3.put_object(Body=json_data, Bucket=BUCKET_NAME, Key=key_name)