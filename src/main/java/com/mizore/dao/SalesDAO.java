package com.mizore.dao;

import com.mizore.entity.dto.SalesRankDTO;
import com.mizore.entity.vo.SalesReportVO;

import java.util.List;

public interface SalesDAO {
    List<SalesRankDTO> getSalesList();
    SalesReportVO getBusinessData();
    long getTotalUserCount();
    long getTotalBookCount();
    long getTodayOrderCount();
}
