package com.project.eduapp.services.lesson.image;

import com.project.eduapp.models.LessonMedia;

public interface ILessonImageService {
    LessonMedia deleteProductImage(Long id) throws Exception;
}
