package com.mizore.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Orders implements Serializable {
    // 根据插入数据，ID 是 UUID 字符串格式
    private String id;

    // 订单总金额 (对应插入数据的 44.5, 59, 89)
    private BigDecimal totalAmount;

    // 收货地址
    private String address;

    // 收件人姓名
    private String receiverName;

    // 收件人电话
    private String receiverPhone;

    // 用户ID (对应插入数据的 1, 0)
    private Long userId;

    // 下单时间
    private LocalDateTime createTime;

    // 订单状态 (对应插入数据的 4, 3)
    private Integer status;
}