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
in details in this GitHub repository https://github.com/robipozzi/robipozzi-kafka, you will find pointers to the appropriate content in the paragraphs below.

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
The application implements a Kafka Producer that publishes fake random temperature data to a Kafka topic called *temperature* 
(configurable in the **[application.properties](src/main/resources/application.properties)** configuration file, simulating the behavior of a real 
Temperature sensor that continuosly reads temperature from the environment and sends it to Kafka.
 
As said in the introduction, the code for this application is based on:
- **Maven**: here is the **[POM](pom.xml)** that defines project configuration; the library dependencies section is reported here below
```
<dependencies>
	<dependency>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter</artifactId>
	</dependency>
	<dependency>
		<groupId>org.springframework.kafka</groupId>
		<artifactId>spring-kafka</artifactId>
	</dependency>
	<dependency>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter-test</artifactId>
		<scope>test</scope>
	</dependency>
	<dependency>
		<groupId>org.springframework.kafka</groupId>
		<artifactId>spring-kafka-test</artifactId>
		<scope>test</scope>
	</dependency>
</dependencies>
```
	
- **Spring Boot 3.1.2**: the usage of Spring Boot framework v3.1.2, with all its implicit dependencies, is declared in the same **[POM](pom.xml)**; 
as any Spring Boot application, it has a specific configuration file called **[application.properties](src/main/resources/application.properties)**
```
<parent>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-parent</artifactId>
	<version>3.1.2</version>
	<relativePath/> <!-- lookup parent from repository -->
</parent>
```

- **Kafka libraries**: they are injected as Spring dependencies, as it can be seen in the **[POM](pom.xml)** dependencies section.

Every Spring Boot application needs to have a main class annotated as **@SpringBootApplication**; our application main class is 
**[KafkaProducerApplication](src/main/java/com/rpozzi/kafka/KafkaProducerApplication.java)**, whose code is reported here below for reference
```
@SpringBootApplication
@ComponentScan(basePackages = { "com.rpozzi.kafka" })
public class KafkaProducerApplication {
	private static final Logger logger = LoggerFactory.getLogger(KafkaProducerApplication.class);
	@Value(value = "${spring.kafka.bootstrap-servers}")
	private String kafkaBootstrapServers;
	@Autowired
	private TemperatureSensorSimulationService temperatureSensorSimulationSrv;
	
	public static void main(String[] args) {
		SpringApplication.run(KafkaProducerApplication.class, args);
	}

	/****************************************************/
	/****** Kafka publish services - Section START ******/
	/****************************************************/
	
    @Bean
    public ApplicationRunner runner() {
        return args -> {
        	while (true) {
        		temperatureSensorSimulationSrv.publish();
        		logger.debug("Sleep for 5 seconds");
        		Thread.sleep(5000);
			}
        };
    }
    
    /**************************************************/
	/****** Kafka publish services - Section END ******/
	/**************************************************/
    
    @Bean
	public CommandLineRunner commandLineRunner(ApplicationContext ctx) {
		return args -> {
			logger.debug("Let's inspect the beans provided by Spring Boot:");
			logger.debug("************** Spring Boot beans - START **************");
			String[] beanNames = ctx.getBeanDefinitionNames();
			Arrays.sort(beanNames);
			for (String beanName : beanNames) {
				logger.debug(beanName);
			}
			logger.debug("************** Spring Boot beans - END **************");
			
			logger.debug("Print application configuration parameters");
			logger.debug("************** Application configuration parameters - START **************");
			logger.debug("Kafka Bootstrap Servers :  " + kafkaBootstrapServers);
			logger.debug("************** Application configuration parameters - END **************");
			
			logger.info("Application " + ctx.getId() + " started !!!");
		};
	}

}
```

It is out of scope of this doc to explain in detail how Spring Boot works, for our purposes let's just concentrate on the piece of code where the "magic" happens:
once the application is started via *main()* method, the *runner()* method is also kicked in, where an infinite *while()* loop calls 
**temperatureSensorSimulationSrv.publish()** every 5 seconds.

But where **temperatureSensorSimulationSrv** comes from? Well it is just an instance of 
**[TemperatureSensorSimulationService](src/main/java/com/rpozzi/kafka/service/TemperatureSensorSimulationService.java)**, whose code is reported below 
for reference, injected via the following Spring Boot annotation 
```
@Autowired
private TemperatureSensorSimulationService temperatureSensorSimulationSrv;
```
The **[TemperatureSensorSimulationService](src/main/java/com/rpozzi/kafka/service/TemperatureSensorSimulationService.java)** class has a *publishMsg()* method 
that uses **KafkaTemplate** (which is an abstraction provided by Spring Framework to interact with Kafka APIs) to publish a message to a Kafka topic called 
*temperature*, injected as property *temperaturesKafkaTopic* (whose value is read from *kafka.topic.temperatures* key in 
**[application.properties](src/main/resources/application.properties)** configuration file).

```
@Service
public class TemperatureSensorSimulationService extends AKafkaProducer {
	private static final String GROUP_ID_CONFIG = "robi-temperatures";
	@Value(value = "${kafka.topic.temperatures}")
	private String temperaturesKafkaTopic;

	@Override
	protected void customizeProducerConfigProps() {
		producerConfigProps.put(ConsumerConfig.GROUP_ID_CONFIG, TemperatureSensorSimulationService.GROUP_ID_CONFIG);
	}

	@Override
	protected void publishMsg(KafkaTemplate<String, Object> kafkaTemplate) {
		SensorSimulator sensorSimulator = new SensorSimulator();
		logger.debug("Sensor Simulator Json string : " + sensorSimulator.toString());
		logger.info("Publishing to '" + temperaturesKafkaTopic + "' Kafka topic (using SpringBoot Kafka APIs) ...");
		kafkaTemplate.send(temperaturesKafkaTopic, sensorSimulator.toString());
	}
}
```
The message published to Kafka is generated by **[SensorSimulator](src/main/java/com/rpozzi/kafka/dto/SensorSimulator.java)** class, which generates
random temperature and humidity data, as the code below shows
```
public class SensorSimulator {
	private int temperature;
	private int humidity;
	private final int TEMPERATURE_MIN = -20;
	private final int TEMPERATURE_MAX = 50;
	private final int HUMIDITY_MIN = 0;
	private final int HUMIDITY_MAX = 100;

	public SensorSimulator() {
		super();
		this.temperature = randomTemperature();
		this.humidity = randomHumidity();
	}

	public int getTemperature() {
		return temperature;
	}

	public void setTemperature(int temperature) {
		this.temperature = temperature;
	}

	public int getHumidity() {
		return humidity;
	}

	public void setHumidity(int humidity) {
		this.humidity = humidity;
	}
	
	private int randomTemperature() {
		return new Random().nextInt(TEMPERATURE_MAX - TEMPERATURE_MIN) + TEMPERATURE_MIN;
	}
	
	private int randomHumidity() {
		return new Random().nextInt(HUMIDITY_MAX - HUMIDITY_MIN) + HUMIDITY_MIN;
	}
	
	public String toString() {
		return "{\"temperature\":" + temperature + ",\"humidity\":" + humidity + "}";				
	}

}
```