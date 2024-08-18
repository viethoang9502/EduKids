package com.project.eduapp.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "lesson_video")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class LessonVideo {
    public static final int MAXIMUM_VIDEOS_PER_PRODUCT = 6;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "lesson_id")
    @JsonIgnore
    private Lesson lesson;

    @Column(name = "video_url", length = 300)
    @JsonProperty("video_url")
    private String videoUrl;
}
