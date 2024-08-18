package com.project.eduapp.responses.progress;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.project.eduapp.models.ProgressDetail;
import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProgressDetailResponse {
    private Long id;

    @JsonProperty("order_id")
    private Long orderId;

    @JsonProperty("product_id")
    private Long productId;

    @JsonProperty("price")
    private Float price;

    @JsonProperty("number_of_products")
    private int numberOfProducts;

    @JsonProperty("total_money")
    private Float totalMoney;

    private String color;

    public static ProgressDetailResponse fromOrderDetail(ProgressDetail orderDetail) {
        return ProgressDetailResponse
                .builder()
                .id(orderDetail.getId())
                .orderId(orderDetail.getOrder().getId())
                .productId(orderDetail.getLesson().getId())
                .price(orderDetail.getMaxScore())
                .numberOfProducts(orderDetail.getProgress())
                .totalMoney(orderDetail.getTotalScore())
                .color(orderDetail.getColor())
                .build();
    }
}
