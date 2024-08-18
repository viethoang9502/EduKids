package com.project.eduapp.responses.progress;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@AllArgsConstructor
@Data
@Builder
@NoArgsConstructor
public class ProgressListResponse {
    private List<ProgressResponse> orders;
    private int totalPages;
}
