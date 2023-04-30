package com.rpozzi.kafka.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;
import com.rpozzi.kafka.dto.SensorSimulator;

@Service
public class TemperatureSensorSimulationService {
	private static final Logger logger = LoggerFactory.getLogger(TemperatureSensorSimulationService.class);
	@Autowired
	private KafkaTemplate<String, String> template;
	@Value(value = "${kafka.topic.temperatures}")
	private String temperaturesKafkaTopic;

	public void publish() {
		SensorSimulator sensorSimulator = new SensorSimulator();
		logger.debug("Sensor Simulator Json string : " + sensorSimulator.toString());
		logger.debug("Publishing to '" + temperaturesKafkaTopic + "' Kafka topic ...");
		template.send(temperaturesKafkaTopic, sensorSimulator.toString());
	}
}