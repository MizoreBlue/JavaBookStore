package com.mizore.servlet.admin;


import com.mizore.entity.dto.SalesRankDTO;
import com.mizore.service.SalesService;
import com.mizore.service.impl.SalesServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.List;

/**
 * 销售榜单
 */
@WebServlet("/backend/sales/*")
public class SalesRakingServlet extends HttpServlet {

    private SalesService salesService = new SalesServiceImpl();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

//        处理uri
        String uri = request.getRequestURI();
        uri = uri.replace("/backend/sales/", "");

        if (uri.equals("list")) {
//            查询榜单数据
            List<SalesRankDTO> salesRankDTOS = salesService.getList();
            request.setAttribute("salesRankDTOS", salesRankDTOS);
//            展示页面
            request.getRequestDispatcher("/WEB-INF/views/admin/sales_ranking.jsp").forward(request, response);
        }

        if (uri.equals("excel")) {
//            下载榜单数据
            salesService.exportExcel(response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
