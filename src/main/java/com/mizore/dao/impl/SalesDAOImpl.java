package com.mizore.dao.impl;

import com.mizore.dao.SalesDAO;
import com.mizore.dao.UserDAO;
import com.mizore.entity.User;
import com.mizore.entity.dto.SalesRankDTO;
import com.mizore.entity.vo.SalesReportVO;
import com.mizore.utils.DruidUtils;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class SalesDAOImpl implements SalesDAO {


    /**
     * 查询销售排行榜列表
     * @return
     */
    public List<SalesRankDTO> getSalesList() {
        List<SalesRankDTO> list = new ArrayList<>();

//        准备多表查询语句
        String sql = "SELECT   b.name AS bookName, b.author AS author, SUM(od.quantity) AS totalSales\n" +
                "FROM   orders o JOIN order_detail od ON o.id = od.order_id JOIN  book b ON od.book_id = b.id WHERE \n" +
                "    o.status = 3   GROUP BY     b.name, b.author ORDER BY  totalSales DESC";

        try(Connection connection = DruidUtils.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery()
        ){
            while (resultSet.next()){
                SalesRankDTO salesRankDTO = new SalesRankDTO();
                salesRankDTO.setTotalSales(resultSet.getInt("totalSales"));
                salesRankDTO.setBookName(resultSet.getString("bookName"));
                salesRankDTO.setAuthor(resultSet.getString("author"));
                list.add(salesRankDTO);
            }
            return list;
        }catch (Exception e){
            e.printStackTrace();
        }
        return  null;
    }


    /**
     * 获取报表文件
     * @return
     */
    public SalesReportVO getBusinessData() {
        return null;
    }
}