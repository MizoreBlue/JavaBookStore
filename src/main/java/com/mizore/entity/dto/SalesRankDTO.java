package com.mizore.entity.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.io.Serializable;

/**
 * 销量排行榜数据传输对象
 * 用于封装：书名、作者、总销量
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SalesRankDTO implements Serializable {

//    书UUID
    private String bookId;

    // 书名
    private String bookName;

    // 作者
    private String author;

    // 总销量
    private Integer totalSales;
}