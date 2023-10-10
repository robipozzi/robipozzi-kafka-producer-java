package com.rpozzi.kafka.service;

import org.apache.kafka.clients.consumer.ConsumerConfig;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;
import com.rpozzi.kafka.common.AKafkaProducer;
import com.rpozzi.kafka.dto.SensorSimulator;

@Service
public class TemperatureSensorSimulationService extends AKafkaProducer {
	private static final String GROUP_ID_CONFIG = "robi-temperatures";
	private static final String SENSOR_KAFKA_MSG_KEY = "sensor-data";
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
		kafkaTemplate.send(temperaturesKafkaTopic, TemperatureSensorSimulationService.SENSOR_KAFKA_MSG_KEY, sensorSimulator.toString());
	}
}