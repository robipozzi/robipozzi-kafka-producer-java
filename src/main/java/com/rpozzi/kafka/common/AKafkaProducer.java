package com.rpozzi.kafka.common;

import java.util.HashMap;
import java.util.Map;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.common.serialization.StringSerializer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.kafka.KafkaProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.kafka.core.DefaultKafkaProducerFactory;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.kafka.core.ProducerFactory;

public abstract class AKafkaProducer implements IKafkaProducer {
	protected final Logger logger;
	@Autowired
	protected KafkaProperties kafkaProperties;
	protected Map<String, Object> producerConfigProps = null;
	private KafkaTemplate<String, Object> kafkaTemplate;

	protected AKafkaProducer() {
		super();
		logger = LoggerFactory.getLogger(this.getClass());
	}
	
	protected abstract void customizeProducerConfigProps();

	@Bean
	protected final Map<String, Object> producerConfigs() {
		logger.debug("===> running producerConfigs() method ...");
		if (producerConfigProps == null) {
			logger.debug("##### instantiating producerConfigProps Map ...");
			producerConfigProps = new HashMap<>(kafkaProperties.buildConsumerProperties());
			producerConfigProps.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class);
			producerConfigProps.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, StringSerializer.class);
			logger.debug("##### customizing producerConfigProps Map ...");
			customizeProducerConfigProps();
		}
		producerConfigProps.forEach((key, value) -> logger.debug("KEY = " + key + " - VALUE = " + value));
		return producerConfigProps;
	}
	
	@Bean
    private ProducerFactory<String, Object> createProducerFactory() {
		logger.debug("===> running createProducerFactory() method ...");
        return new DefaultKafkaProducerFactory<>(producerConfigs());
    }

    @Bean
    private KafkaTemplate<String, Object> createKafkaTemplate() {
    	logger.debug("===> running createKafkaTemplate() method ...");
        return new KafkaTemplate<>(createProducerFactory());
    }

	@Override
	public void publish() {
		logger.debug("===> running publish() method ...");
		if (kafkaTemplate == null) {
			logger.debug("===> creating KafkaTemplate instance");
			kafkaTemplate = createKafkaTemplate();
		}
		publishMsg(kafkaTemplate);
	}
	
	protected abstract void publishMsg(KafkaTemplate<String, Object> kafkaTemplate);

}