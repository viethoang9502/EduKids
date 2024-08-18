package com.project.eduapp.models;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "lessons")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
//Event-driven approach with Spring Data JPA
@EntityListeners(LessonListener.class)
public class Lesson extends BaseEntity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name", nullable = false, length = 350)
    private String name;

    private Float price;

    @Column(name = "thumbnail", length = 300)
    private String thumbnail;

    @Column(name = "description")
    private String description;

    @ManyToOne
    @JoinColumn(name = "category_id")
    private Category category;

    @OneToMany(mappedBy = "lesson",
            cascade = CascadeType.ALL,
            fetch = FetchType.LAZY)
    private List<LessonMedia> productImages;

    @OneToMany(mappedBy = "lesson",
            cascade = CascadeType.ALL,
            fetch = FetchType.LAZY)
    private List<LessonVideo> productVideos;

    @OneToMany(mappedBy = "lesson",
            cascade = CascadeType.ALL,
            fetch = FetchType.LAZY)
    private List<LessonGame> lessonGames;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL)
    @JsonManagedReference
    private List<Comment> comments = new ArrayList<>();

    @OneToMany(mappedBy = "product",
            cascade = CascadeType.ALL,
            fetch = FetchType.LAZY)
    private List<Favorite> favorites;
}
/*
SELECT products.* FROM products LEFT JOIN product_images ON products.id = product_images.product_id WHERE product_images.product_id IS NULL AND category_id=4 LIMIT 10;
select * from products where category_id=4;
* */