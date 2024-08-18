package com.project.eduapp.responses.lesson;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.project.eduapp.models.Lesson;
import com.project.eduapp.models.LessonGame;
import com.project.eduapp.models.LessonMedia;
import com.project.eduapp.models.LessonVideo;
import com.project.eduapp.responses.BaseResponse;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class LessonResponse extends BaseResponse {
    private Long id;
    private String name;
    private Float price;
    private String thumbnail;
    private String description;
    // Thêm trường totalPages
    private int totalPages;

    @JsonProperty("lesson_images")
    private List<LessonMedia> lessonImages = new ArrayList<>();

    @JsonProperty("lesson_videos")
    private List<LessonVideo> lessonVideos = new ArrayList<>();

    @JsonProperty("lesson_games")
    private List<LessonGame> lessonGames = new ArrayList<>();

    @JsonProperty("category_id")
    private Long categoryId;
    public static LessonResponse fromProduct(Lesson product) {
        LessonResponse productResponse = LessonResponse.builder()
                .id(product.getId())
                .name(product.getName())
                .price(product.getPrice())
                .thumbnail(product.getThumbnail())
                .description(product.getDescription())
                .categoryId(product.getCategory().getId())
                .lessonImages(product.getProductImages())
                .lessonVideos(product.getProductVideos())
                .lessonGames(product.getLessonGames())
                .build();
        productResponse.setCreatedAt(product.getCreatedAt());
        productResponse.setUpdatedAt(product.getUpdatedAt());
        return productResponse;
    }
}
