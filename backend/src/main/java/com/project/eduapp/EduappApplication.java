package com.project.eduapp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
//@ImportAutoConfiguration(AopAutoConfiguration.class)
//@SpringBootApplication(exclude = KafkaAutoConfiguration.class), disable in "application.yml"
public class EduappApplication {
	public static void main(String[] args) {
		SpringApplication.run(EduappApplication.class, args);
	}

}
/*
docker start zookeeper-01
docker start zookeeper-02
docker start zookeeper-03

docker restart kafka-broker-01
* */