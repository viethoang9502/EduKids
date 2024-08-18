package com.project.eduapp.models;

import com.project.eduapp.services.lesson.ILessonRedisService;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/*
Install Debezium and configure it to capture changes in the MySQL product table.

Set up a Kafka Connect destination to consume the Debezium change data events.

Implement a Spring Boot application that subscribes to the Kafka Connect destination and updates the Redis cache accordingly.
* */
@AllArgsConstructor
public class LessonListener {
    private final ILessonRedisService productRedisService;
    private static final Logger logger = LoggerFactory.getLogger(LessonListener.class);
    @PrePersist
    public void prePersist(Lesson product) {
        logger.info("prePersist");
    }

    @PostPersist //save = persis
    public void postPersist(Lesson product) {
        // Update Redis cache
        logger.info("postPersist");
        productRedisService.clear();
    }

    @PreUpdate
    public void preUpdate(Lesson product) {
        //ApplicationEventPublisher.instance().publishEvent(event);
        logger.info("preUpdate");
    }

    @PostUpdate
    public void postUpdate(Lesson product) {
        // Update Redis cache
        logger.info("postUpdate");
        productRedisService.clear();
    }

    @PreRemove
    public void preRemove(Lesson product) {
        //ApplicationEventPublisher.instance().publishEvent(event);
        logger.info("preRemove");
    }

    @PostRemove
    public void postRemove(Lesson product) {
        // Update Redis cache
        logger.info("postRemove");
        productRedisService.clear();
    }
}
