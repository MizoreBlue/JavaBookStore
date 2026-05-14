package com.mizore.dao;

import com.mizore.entity.dto.SalesRankDTO;
import com.mizore.entity.vo.SalesReportVO;

import java.util.List;

public interface SalesDAO {

    /**
     * 查询销售列表
     * @return
     */
    List<SalesRankDTO> getSalesList();


    /**
     * 获取报表文件数据
     * @return
     */
    SalesReportVO getBusinessData();
}
