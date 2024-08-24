package com.project.eduapp.controllers;

import com.project.eduapp.models.LessonVideo;
import com.project.eduapp.responses.ResponseObject;
import com.project.eduapp.services.lesson.LessonService;
import com.project.eduapp.services.lesson.image.ILessonImageService;
import com.project.eduapp.services.lesson.video.ILessonVideoService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("${api.prefix}/lesson_videos")
//@Validated
//Dependency Injection
@RequiredArgsConstructor
public class ProductVideoController {
    private final ILessonVideoService productVideoService;
    private final LessonService productService;
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<ResponseObject> delete(
            @PathVariable Long id
    ) throws Exception {
        LessonVideo productVideo = productVideoService.deleteProductVideo(id);
        if(productVideo != null){
            productService.deleteFile(productVideo.getVideoUrl());
        }
        return ResponseEntity.ok().body(
                ResponseObject.builder()
                        .message("Delete product image successfully")
                        .data(productVideo)
                        .status(HttpStatus.OK)
                        .build()
        );
    }
}
