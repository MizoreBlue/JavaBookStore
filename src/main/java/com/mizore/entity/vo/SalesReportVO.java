package com.mizore.entity.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.io.Serializable;

/**
 * 销售报表视图对象 (用于 Excel 导出)
 * 包含报表元数据（时间、标题）以及具体的销售明细数据
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SalesReportVO implements Serializable {

    /**
     * 报表元数据（非列表数据，用于表头展示）
     */

    // 报表标题（例如：2026年5月销售排行榜）
    private String reportTitle;

    // 统计年份
    private String year;

    // 统计月份
    private String month;

    // 导出时间（精确到秒，用于记录生成报表的时间）
    private String exportTime;


    // --- 以下是 Excel 每一行对应的数据 ---

    // 排名（Excel 中通常会有序号列）
    private Integer rank;

    // 书名
    private String bookName;

    // 作者
    private String author;

    // 总销量
    private Integer totalSales;
}