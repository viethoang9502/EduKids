package com.project.eduapp.repositories;

import com.project.eduapp.models.LessonVideo;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProductVideoRepository extends JpaRepository<LessonVideo, Long> {
    List<LessonVideo> findByLessonId(Long lessonId);

}
