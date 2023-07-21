# Stock Market Pipeline using Kafka and AWS

## Reproducability
### Obtaining your twelvedata api-key
Make a free account with [twelvedata](https://twelvedata.com/) to obtain access to their stock  api. Follow the signup process, and save your api_key for later use.
### Instance 1: the Kafka Server
- Create a new EC2 instance named "Kafka Server"
    - Choose Ubuntu OS and t2.small for the size
    - allow Port 22 inbound traffic from your IP
    - allow Port 9092 inbound traffic from the CIDR range corresponding to the VPC of this instance
- After the instance is created, ssh into it
- Once there, run `git clone https://github.com/PeoplesJWilson/stock-market-pipeline.git` to clone this repo to your instance
- Navigate to the __ec2_kafka_server__ folder
- Add execution privileges to the shell files in this directory with the command `chmod +x *.sh`
- run the setup script with `./ec2_kafka_server_setup.sh`, answering yes when prompted
- run `nano ec2_kafka_server_runme.sh` and enter the private IP DNS name for this instance. Configure any other environment variables to your liking.
- setup the kafka server by running `./ec2_kafka_server_runme.sh`

### Instance 2: the Consumer
- Create a new EC2 instance named "Consumer"
    - Choose Ubuntu OS and t2.small for the size.
    - Allow Port 22 inbound traffic from your IP.
    - Allow Port 9092 inbound traffic from the CIDR. range corresponding to the __single private IPV4 of the Kafka Server instance above__.
    - Add an IAM role allowing S3 write permissions.
- After the instance is created, ssh into it
- Once there, run `git clone https://github.com/PeoplesJWilson/stock-market-pipeline.git` to clone this repo to your instance
- Navigate to the __ec2_consumer__ folder
- Add execution privileges to the shell files in this directory with the command `chmod +x *.sh`
- run the setup script with `./ec2_consumer_setup.sh`, answering yes when prompted
- run `nano ec2_consumer_runme.sh` and enter the private IP DNS name for the Kafka server instance, as well as your desired bucket name. Configure any other environment variables to your liking.
- begin consuming from the kafka server by running `./ec2_consumer_runme.sh`

### Instance 3: the Consumer
- Create a new EC2 instance named "Producer"
    - Choose __Amazon Linux__ OS and t2.small for the size.
    - Allow Port 22 inbound traffic from your IP.
    - Allow Port 9092 inbound traffic from the CIDR. range corresponding to the __single private IPV4 of the Kafka Server instance above__.
    - Add an IAM role allowing S3 make bucket permissions.
- After the instance is created, ssh into it
- install git with `sudo yum install git`
- run `git clone https://github.com/PeoplesJWilson/stock-market-pipeline.git` to clone this repo to your instance
- Navigate to the __ec2_producer__ folder
- Add execution privileges to the shell files in this directory with the command `chmod +x *.sh`
- run the setup script with `./ec2_producer_setup.sh`, answering yes when prompted
- run `nano ec2_producer_runme.sh` and enter your twelvedata api key, the private IP DNS name for the Kafka server instance, and your desired bucket name. Configure any other environment variables to your liking.
- begin producing to the kafka server by running `./ec2_producer_runme.sh`

