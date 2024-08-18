package com.project.eduapp.services.lesson;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.project.eduapp.responses.lesson.LessonResponse;
import org.springframework.data.domain.PageRequest;

import java.util.List;

public interface ILessonRedisService {
    //Clear cached data in Redis
    void clear();//clear cache
    List<LessonResponse> getAllProducts(
            String keyword,
            Long categoryId, PageRequest pageRequest) throws JsonProcessingException;
    void saveAllProducts(List<LessonResponse> productResponses,
                                String keyword,
                                Long categoryId,
                                PageRequest pageRequest) throws JsonProcessingException;

}
