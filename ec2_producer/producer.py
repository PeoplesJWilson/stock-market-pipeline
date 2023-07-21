from time import sleep,time
from json import dumps
import os

from kafka import KafkaProducer
from twelvedata import TDClient

API_KEY = os.environ["TWELVE_DATA_KEY"]
SERVER_PORT = os.environ["SERVER_PORT"]
TOPIC_NAME = os.environ["TOPIC_NAME"]
SYMBOL = os.environ["SYMBOL"]
N_SAMPLES = int(os.environ["N_SAMPLES"])



producer = KafkaProducer(bootstrap_servers = [SERVER_PORT],
                         value_serializer = lambda x: dumps(x).encode('utf-8'),
                         api_version = (0,10,2))
print("producer started")


td = TDClient(apikey=API_KEY)
print("connceted to API")

for i in range(N_SAMPLES):
    sleep(10)
    price = td.price(symbol=SYMBOL)
    data = price.as_json()
    data["time"] = time()
    producer.send(TOPIC_NAME,value=data)