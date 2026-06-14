package com.mizore.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigDecimal;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OrderDetail implements Serializable {
    private Long id;
    private Long orderId;
    private Long bookId;
    private Integer number;
    private BigDecimal amount;
    private String image;
    private String bookName;
}
