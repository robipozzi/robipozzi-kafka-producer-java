# Kafka Java Producer
- [Introduction](#introduction)
- [Setup and run Kafka](#setup-and-run-kafka)
    - [Run Kafka cluster on local environment](#run-Kafka-cluster-on-local-environment)
    - [Run Kafka cluster on Confluent](#run-Kafka-cluster-on-confluent)
    - [Create, delete and describe Kafka topics](#create-delete-and-describe-kafka-topics)
    - [Producers and consumers using Kafka command line tools](#producers-and-consumers-using-Kafka-command-line-tools)
- [How the application works](#how-the-application-works)
    
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
in details in this GitHub repository https://github.com/robipozzi/robipozzi-kafka, you will find pointers to the appropriate content in the paragraphs below;.

### Run Kafka cluster on local environment
One option to run a Kafka cluster is obviously installing and running locally, please refer to https://github.com/robipozzi/robipozzi-kafka#run-Kafka-cluster-on-local-environment
for all the details.

### Run Kafka cluster on Confluent
Another option to setup a Kafka cluster is to use a Cloud solution, for instance Confluent (https://www.confluent.io/), you can refer to https://github.com/robipozzi/robipozzi-kafka#run-Kafka-cluster-on-confluent 
for details regarding this option.

### Create, delete and describe Kafka topics
Once the Kafka cluster has been setup, you can find details on how to manage topics (i.e.: create, delete, ...) at https://github.com/robipozzi/robipozzi-kafka#create-delete-and-describe-kafka-topics

### Producers and consumers using Kafka command line tools
The code in this repository is focused on Kafka producers exclusively, so you won't find any example of usable Kafka consumers; luckily
Kafka provides a very convenient way to start consumers via command line: refer to https://github.com/robipozzi/robipozzi-kafka#producers-and-consumers-using-Kafka-command-line-tools
for details and examples.

## How the application works
As said in the introduction, the code for this application is based on:
- Maven : here is the POM(#pom.xml) that 
- Spring Boot 3.1.2 and Kafka libraries, injected as Spring dependencies.