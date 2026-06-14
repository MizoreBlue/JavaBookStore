package com.mizore.service;

import com.mizore.dao.SalesDAO;
import com.mizore.entity.dto.SalesRankDTO;
import com.mizore.entity.vo.SalesReportVO;

import java.util.List;

public class SalesService {

    private SalesDAO salesDAO = ServiceFactory.getSalesDAO();

    public List<SalesRankDTO> getSalesRank() {
        return salesDAO.getSalesList();
    }

    public SalesReportVO getBusinessReport() {
        return salesDAO.getBusinessData();
    }

    public long getTotalUserCount() {
        return salesDAO.getTotalUserCount();
    }

    public long getTotalBookCount() {
        return salesDAO.getTotalBookCount();
    }

    public long getTodayOrderCount() {
        return salesDAO.getTodayOrderCount();
    }
}
