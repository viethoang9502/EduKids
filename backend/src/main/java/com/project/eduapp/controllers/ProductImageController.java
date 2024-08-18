package com.project.eduapp.controllers;


import com.project.eduapp.models.LessonMedia;
import com.project.eduapp.responses.ResponseObject;
import com.project.eduapp.services.lesson.LessonService;
import com.project.eduapp.services.lesson.image.ILessonImageService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("${api.prefix}/lesson_images")
//@Validated
//Dependency Injection
@RequiredArgsConstructor
public class ProductImageController {
    private final ILessonImageService productImageService;
    private final LessonService productService;
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<ResponseObject> delete(
            @PathVariable Long id
    ) throws Exception {
        LessonMedia productImage = productImageService.deleteProductImage(id);
        if(productImage != null){
            productService.deleteFile(productImage.getImageUrl());
        }
        return ResponseEntity.ok().body(
                ResponseObject.builder()
                        .message("Delete product image successfully")
                        .data(productImage)
                        .status(HttpStatus.OK)
                        .build()
        );
    }
}
