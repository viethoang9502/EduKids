package com.project.eduapp.models;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "progress_details")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProgressDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "progress_id")
    @JsonBackReference
    private Progress order;

    @ManyToOne
    @JoinColumn(name = "lesson_id")
    private Lesson lesson;

    @Column(name = "max_score", nullable = false)
    private Float maxScore;

    @Column(name = "progress", nullable = false)
    private int progress;

    @Column(name = "total_score", nullable = false)
    private Float totalScore;

    @Column(name = "break_start")
    private String color;

    @ManyToOne
    @JoinColumn(name = "reward_id", nullable = true)
    @JsonBackReference
    private Coupon coupon;
}
