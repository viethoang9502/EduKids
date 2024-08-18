package com.project.eduapp.repositories;

import com.project.eduapp.models.*;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FavoriteRepository extends JpaRepository<Favorite, Long> {
    boolean existsByUserIdAndProductId(Long userId, Long productId);
    Favorite findByUserIdAndProductId(Long userId, Long productId);
}


