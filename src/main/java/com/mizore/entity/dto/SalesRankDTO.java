package com.mizore.entity.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SalesRankDTO implements Serializable {
    private Long bookId;
    private String bookName;
    private String author;
    private Integer totalSales;
}
