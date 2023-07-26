package com.rpozzi.kafka.common;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.kafka.KafkaProperties;
import org.springframework.context.annotation.Bean;

public abstract class AKafkaProducer implements IKafkaProducer {
	protected final Logger logger;
	@Autowired
	protected KafkaProperties kafkaProperties;
	protected Map<String, Object> producerConfigProps = null;

	protected AKafkaProducer() {
		super();
		logger = LoggerFactory.getLogger(this.getClass());
	}
	
	protected abstract void customizeProducerConfigProps();

	@Bean
	protected Map<String, Object> producerConfigs() {
		logger.debug("===> running producerConfigs() method ...");
		if (producerConfigProps == null) {
			logger.debug("##### instantiating producerConfigProps Map ...");
			producerConfigProps = new HashMap<>(kafkaProperties.buildConsumerProperties());
			logger.debug("##### customizing producerConfigProps Map ...");
			customizeProducerConfigProps();
		}
		producerConfigProps.forEach((key, value) -> logger.debug("KEY = " + key + " - VALUE = " + value));
		return producerConfigProps;
	}

	@Override
	public void publish() {
		logger.debug("===> running publish() method ...");
		publishMsg();
	}
	
	protected abstract void publishMsg();

}