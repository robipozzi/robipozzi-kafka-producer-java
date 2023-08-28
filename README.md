# Kafka Java Producer
- [Introduction](#introduction)
- [Setup and run Kafka](#setup-and-run-kafka)
    - [Run Kafka cluster on local environment](#run-Kafka-cluster-on-local-environment)
    - [Run Kafka cluster on Confluent](#run-Kafka-cluster-on-confluent)
    - [Create, delete and describe Kafka topics](#create-delete-and-describe-kafka-topics)
    - [Producers and consumers using Kafka command line tools](#producers-and-consumers-using-Kafka-command-line-tools)
    
## Introduction
This repository provides code and scripts to experiment with Kafka producer Java client technology.

The code is organized in a Maven based project, it uses Spring Boot 3.1.2 and Kafka libraries, injected as Spring dependencies.

To access the code, open a Terminal and start by cloning this repository with the following commands:

```
mkdir $HOME/dev
cd $HOME/dev
git clone https://github.com/robipozzi/robipozzi-kafka-producer-java
```

## Setup and run Kafka
To see how a Kafka producer works, you will need to setup a few things in advance, such as a Kafka cluster to interact with and Kafka topic to produce and consume 
messages; also it could be useful to have some Kafka consumers to test the messages have been correctly produced by our Kafka producer: everything is already described
in details in this GitHub repository https://github.com/robipozzi/robipozzi-kafka, you will find pointers to the appropriate content in the paragraphs below; 

### Run Kafka cluster on local environment
One option to run a Kafka cluster is obviously installing and running locally, please refer to https://github.com/robipozzi/robipozzi-kafka#run-Kafka-cluster-on-local-environment
for all the details.

### Run Kafka cluster on Confluent
Refer to https://github.com/robipozzi/robipozzi-kafka#run-Kafka-cluster-on-confluent

### Create, delete and describe Kafka topics
https://github.com/robipozzi/robipozzi-kafka#create-delete-and-describe-kafka-topics

### Producers and consumers using Kafka command line tools
Refer to https://github.com/robipozzi/robipozzi-kafka#producers-and-consumers-using-Kafka-command-line-tools