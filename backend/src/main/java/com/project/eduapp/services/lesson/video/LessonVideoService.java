package com.project.eduapp.services.lesson.video;

import com.project.eduapp.exceptions.DataNotFoundException;
import com.project.eduapp.models.LessonVideo;
import com.project.eduapp.repositories.ProductVideoRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class LessonVideoService implements ILessonVideoService {
    private final ProductVideoRepository productVideoRepository;
    @Override
    @Transactional
    public LessonVideo deleteProductVideo(Long id) throws Exception {
        Optional<LessonVideo> productVideo = productVideoRepository.findById(id);
        if(productVideo.isEmpty()) {
            throw new DataNotFoundException(
                    String.format("Cannot find product video with id: %d", id)
            );
        }
        productVideoRepository.deleteById(id);
        return productVideo.get();
    }
}
