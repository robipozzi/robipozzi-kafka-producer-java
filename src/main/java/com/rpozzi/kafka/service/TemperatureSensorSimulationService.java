package com.rpozzi.kafka.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;
import com.rpozzi.kafka.common.AKafkaProducer;
import com.rpozzi.kafka.dto.SensorSimulator;

@Service
public class TemperatureSensorSimulationService extends AKafkaProducer {
	@Autowired
	private KafkaTemplate<String, String> template;
	@Value(value = "${kafka.topic.temperatures}")
	private String temperaturesKafkaTopic;

	@Override
	protected void customizeProducerConfigProps() {
		
	}

	@Override
	protected void publishMsg() {
		SensorSimulator sensorSimulator = new SensorSimulator();
		logger.debug("Sensor Simulator Json string : " + sensorSimulator.toString());
		logger.info("Publishing to '" + temperaturesKafkaTopic + "' Kafka topic (using SpringBoot Kafka APIs) ...");
		template.send(temperaturesKafkaTopic, sensorSimulator.toString());
	}
}