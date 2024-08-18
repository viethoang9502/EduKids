package com.project.eduapp.models;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "progress")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Progress {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @Column(name = "lesson_name", length = 100)
    private String fullName;

    @Column(name = "email", length = 100)
    private String email;

    @Column(name = "phone_number",nullable = false, length = 100)
    private String phoneNumber;

    @Column(name = "address", length = 100)
    private String address;

    @Column(name = "email_reminder", length = 100)
    private String note;

    @Column(name="date_started")
    private LocalDate orderDate;

    @Column(name = "status")
    private String status;

    @Column(name = "progress")
    private Float totalMoney;

    @Column(name = "study_method")
    private String shippingMethod;

    @Column(name = "study_address")
    private String shippingAddress;

    @Column(name = "reminder_date")
    private LocalDate shippingDate;

    @Column(name = "tracking_number")
    private String trackingNumber;

    @Column(name = "learning_method")
    private String paymentMethod;

    @Column(name = "active")
    private Boolean active;//thuộc về admin

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonManagedReference
    private List<ProgressDetail> orderDetails;

    @ManyToOne
    @JoinColumn(name = "reward_id", nullable = true)
    @JsonBackReference
    private Coupon coupon = null;
}
