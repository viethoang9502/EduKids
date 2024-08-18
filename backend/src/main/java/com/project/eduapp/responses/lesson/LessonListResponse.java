package com.project.eduapp.responses.lesson;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@AllArgsConstructor
@Data
@Builder
@NoArgsConstructor
public class LessonListResponse {
    private List<LessonResponse> lessons;
    private int totalPages;
}
