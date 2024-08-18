package com.project.eduapp.repositories;

import com.project.eduapp.models.LessonMedia;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProductImageRepository extends JpaRepository<LessonMedia, Long> {
    List<LessonMedia> findByLessonId(Long lessonId);

}
