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
public class Cart implements Serializable {
    private Long id;
    private Long bookId;
    private String name;
    private String image;
    private BigDecimal price;
    private Integer quantity;
    private BigDecimal amount;
}
