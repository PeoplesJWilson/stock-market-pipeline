#!/bin/bash
sudo yum update
sudo yum install python3-pip
sudo pip install -r requirements.txt

# install java 
sudo yum install openjdk-17-jdk openjdk-17-jre