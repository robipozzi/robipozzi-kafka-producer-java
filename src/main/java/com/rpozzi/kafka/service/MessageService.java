package com.rpozzi.kafka.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

@Service
public class MessageService {
	@Autowired
	private KafkaTemplate<String, String> template;
	@Value(value = "${kafka.topic.quickstartevents}")
	private String quickstartEventsKafkaTopic;

	public void publish(String outputMessage) {
		template.send(quickstartEventsKafkaTopic, outputMessage);
	}
}