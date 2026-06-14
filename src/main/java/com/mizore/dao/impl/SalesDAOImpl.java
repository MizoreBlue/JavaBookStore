package com.mizore.dao.impl;

import com.mizore.utils.DbUtilsConfig;

import com.mizore.dao.SalesDAO;
import com.mizore.entity.dto.SalesRankDTO;
import com.mizore.entity.vo.SalesReportVO;
import com.mizore.utils.DruidUtils;
import com.mizore.utils.DbUtilsConfig;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;
import java.util.Map;

public class SalesDAOImpl implements SalesDAO {

    private QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());

    @Override
    public List<SalesRankDTO> getSalesList() {
        String sql = "SELECT b.id AS bookId, b.name AS bookName, b.author AS author, COALESCE(SUM(od.number), 0) AS totalSales " +
                "FROM book b " +
                "LEFT JOIN order_detail od ON b.id = od.book_id " +
                "GROUP BY b.id, b.name, b.author " +
                "ORDER BY totalSales DESC, b.id DESC";
        try {
            List<SalesRankDTO> list = queryRunner.query(sql, DbUtilsConfig.newBeanListHandler(SalesRankDTO.class));
            return list != null ? list : Collections.emptyList();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public SalesReportVO getBusinessData() {
        String sql = "SELECT " +
                "COALESCE(SUM(o.total_amount), 0) AS totalAmount, " +
                "COUNT(DISTINCT o.id) AS orderCount, " +
                "COALESCE(SUM(od.number), 0) AS totalBookCount " +
                "FROM orders o " +
                "LEFT JOIN order_detail od ON o.id = od.order_id " +
                "WHERE o.status = 1";
        try {
            Map<String, Object> map = queryRunner.query(sql, new MapHandler());
            SalesReportVO vo = new SalesReportVO();
            if (map != null) {
                Object amount = map.get("totalAmount");
                Object orders = map.get("orderCount");
                Object books = map.get("totalBookCount");
                vo.setTotalAmount(amount instanceof BigDecimal ? (BigDecimal) amount : BigDecimal.ZERO);
                vo.setOrderCount(orders instanceof Number ? ((Number) orders).intValue() : 0);
                vo.setTotalBookCount(books instanceof Number ? ((Number) books).intValue() : 0);
            } else {
                vo.setTotalAmount(BigDecimal.ZERO);
                vo.setOrderCount(0);
                vo.setTotalBookCount(0);
            }
            return vo;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public long getTotalUserCount() {
        String sql = "SELECT COUNT(*) FROM user";
        try {
            Number num = queryRunner.query(sql, new ScalarHandler<>());
            return num != null ? num.longValue() : 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public long getTotalBookCount() {
        String sql = "SELECT COUNT(*) FROM book";
        try {
            Number num = queryRunner.query(sql, new ScalarHandler<>());
            return num != null ? num.longValue() : 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public long getTodayOrderCount() {
        String sql = "SELECT COUNT(*) FROM orders WHERE DATE(create_time) = CURDATE()";
        try {
            Number num = queryRunner.query(sql, new ScalarHandler<>());
            return num != null ? num.longValue() : 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}

