package com.project.eduapp.dtos;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.Min;
import lombok.*;

@Data//toString
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class LessonGameDTO {
    @JsonProperty("lesson_id")
    @Min(value = 1, message = "Product's ID must be > 0")
    private Long lessonId;

    @JsonProperty("game_type")
    private String gameType;

    @JsonProperty("game_data")
    private String gameData;
}
