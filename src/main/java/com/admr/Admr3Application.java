package com.admr;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

@SpringBootApplication
@EnableConfigurationProperties
@EntityScan(basePackages = {"com.admr.Entity"})  // scan JPA entities
public class Admr3Application {

	public static void main(String[] args) {
		SpringApplication.run(Admr3Application.class, args);
	}

}
