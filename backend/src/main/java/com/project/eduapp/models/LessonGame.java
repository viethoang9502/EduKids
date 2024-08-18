package com.project.eduapp.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "lesson_game")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class LessonGame {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "lesson_id")
    @JsonIgnore
    private Lesson lesson;

    @Column(name = "game_type")
    @JsonProperty("game_type")
    private String gameType;

    @Column(name = "game_data")
    @JsonProperty("game_data")
    private String gameData;
}
