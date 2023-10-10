package com.rpozzi.kafka.dto;

import java.util.Random;

public class SensorSimulator {
	private int temperature;
	private int humidity;
	private final int TEMPERATURE_MIN = 20;
	private final int TEMPERATURE_MAX = 28;
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