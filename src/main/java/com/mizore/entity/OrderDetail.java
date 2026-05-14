package com.mizore.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.io.Serializable;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OrderDetail implements Serializable {
    // 关联的订单ID
    private String orderId;

    // 关联的图书ID
    private String bookId;

    // 购买数量 (对应插入数据的 1)
    private Integer quantity;
}