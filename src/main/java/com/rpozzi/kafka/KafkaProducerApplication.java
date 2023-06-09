package com.rpozzi.kafka;

import java.util.Arrays;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.kafka.core.KafkaTemplate;
import com.rpozzi.kafka.service.TemperatureSensorSimulationService;

@SpringBootApplication
public class KafkaProducerApplication {
	private static final Logger logger = LoggerFactory.getLogger(KafkaProducerApplication.class);
	@Autowired
	private TemperatureSensorSimulationService temperatureSensorSimulationSrv;
	
	public static void main(String[] args) {
		ApplicationContext ctx = SpringApplication.run(KafkaProducerApplication.class, args);
		logger.info("Application " + ctx.getId() + " started !!!");
	}

	/****************************************************/
	/****** Kafka publish services - Section START ******/
	/****************************************************/
	
    @Bean
    public ApplicationRunner runner(KafkaTemplate<String, String> template) {
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
		};
	}

}