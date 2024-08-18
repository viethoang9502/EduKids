package com.project.eduapp.services.lesson;
import com.project.eduapp.dtos.ProductDTO;
import com.project.eduapp.dtos.ProductImageDTO;
import com.project.eduapp.dtos.ProductVideoDTO;
import com.project.eduapp.responses.lesson.LessonResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import com.project.eduapp.models.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface ILessonService {
    Lesson createProduct(ProductDTO productDTO) throws Exception;
    Lesson getProductById(long id) throws Exception;
    public Page<LessonResponse> getAllProducts(String keyword,
                                               Long categoryId, PageRequest pageRequest);
    Lesson updateProduct(long id, ProductDTO productDTO) throws Exception;
    void deleteProduct(long id);
    boolean existsByName(String name);
    LessonMedia createProductImage(
            Long productId,
            ProductImageDTO productImageDTO) throws Exception;
    LessonVideo createProductVideo(
            Long lessonId,
            ProductVideoDTO productImageDTO) throws Exception;

    List<Lesson> findProductsByIds(List<Long> productIds);
    String storeFile(MultipartFile file) throws IOException;

    String storeVideoFile(MultipartFile file) throws IOException;

    void deleteFile(String filename) throws IOException;

    Lesson likeProduct(Long userId, Long productId) throws Exception;
    Lesson unlikeProduct(Long userId, Long productId) throws Exception;
    List<LessonResponse> findFavoriteProductsByUserId(Long userId) throws Exception;
}
