package com.project.eduapp.repositories;

import com.project.eduapp.models.Category;
import com.project.eduapp.models.Lesson;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.domain.*;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface LessonRepository extends JpaRepository<Lesson, Long> {
    boolean existsByName(String name);
    Page<Lesson> findAll(Pageable pageable);//phân trang
    List<Lesson> findByCategory(Category category);
    @Query("SELECT p FROM Lesson p WHERE " +
            "(:categoryId IS NULL OR :categoryId = 0 OR p.category.id = :categoryId) " +
            "AND (:keyword IS NULL OR :keyword = '' OR p.name LIKE %:keyword% OR p.description LIKE %:keyword%)")
    Page<Lesson> searchProducts
            (@Param("categoryId") Long categoryId,
             @Param("keyword") String keyword, Pageable pageable);
    @Query("SELECT p FROM Lesson p LEFT JOIN FETCH p.productImages WHERE p.id = :productId")
    Optional<Lesson> getDetailProduct(@Param("productId") Long productId);

    @Query("SELECT p FROM Lesson p WHERE p.id IN :productIds")
    List<Lesson> findProductsByIds(@Param("productIds") List<Long> productIds);

    @Query("SELECT p FROM Lesson p JOIN p.favorites f WHERE f.user.id = :userId")
    List<Lesson> findFavoriteProductsByUserId(@Param("userId") Long userId);

}
