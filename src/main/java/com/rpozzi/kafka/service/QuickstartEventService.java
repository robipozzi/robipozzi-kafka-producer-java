package com.rpozzi.kafka.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

@Service
public class QuickstartEventService {
	private static final Logger logger = LoggerFactory.getLogger(QuickstartEventService.class);
	@Autowired
	private KafkaTemplate<String, String> template;
	@Value(value = "${kafka.topic.quickstartevents}")
	private String quickstartEventsKafkaTopic;

	public void publish(String outputMessage) {
		logger.debug("Publishing to '" + quickstartEventsKafkaTopic + "' Kafka topic (using SpringBoot Kafka APIs) ...");
		template.send(quickstartEventsKafkaTopic, outputMessage);
	}
}