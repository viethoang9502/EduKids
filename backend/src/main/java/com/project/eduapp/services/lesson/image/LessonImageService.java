package com.project.eduapp.services.lesson.image;

import com.project.eduapp.exceptions.DataNotFoundException;
import com.project.eduapp.models.LessonMedia;
import com.project.eduapp.repositories.ProductImageRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class LessonImageService implements ILessonImageService{
    private final ProductImageRepository productImageRepository;
    @Override
    @Transactional
    public LessonMedia deleteProductImage(Long id) throws Exception {
        Optional<LessonMedia> productImage = productImageRepository.findById(id);
        if(productImage.isEmpty()) {
            throw new DataNotFoundException(
                    String.format("Cannot find product image with id: %ld", id)
            );
        }
        productImageRepository.deleteById(id);
        return productImage.get();
    }
}
