package com.mizore.entity.vo;

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
public class SalesReportVO implements Serializable {
    private BigDecimal totalAmount;
    private Integer orderCount;
    private Integer totalBookCount;
}
