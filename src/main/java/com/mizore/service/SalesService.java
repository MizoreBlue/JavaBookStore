package com.mizore.service;

import com.mizore.entity.dto.SalesRankDTO;
import jakarta.servlet.http.HttpServletResponse;

import java.util.List;

public interface SalesService {


    /**
     * 获取销量排行榜
     * @return
     */
    List<SalesRankDTO> getList();


    /**
     * 返回数据报表
     * @param response
     */
    void exportExcel(HttpServletResponse response);
}
