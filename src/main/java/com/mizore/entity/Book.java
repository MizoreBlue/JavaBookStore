package com.mizore.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Book implements Serializable {
    // 根据插入数据，ID 是 UUID 字符串格式
    private String id;

    private String name;

    private String author;

    private String description;

    private String category;

    private String image;

    private BigDecimal price;

    // 库存
    private Integer stock;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    private Long createUser;

    private Long updateUser;
}