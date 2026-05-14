package com.mizore.service.impl;

import com.mizore.dao.BookDAO;
import com.mizore.dao.OrderDetailDAO;
import com.mizore.dao.SalesDAO;
import com.mizore.dao.impl.BookDAOImpl;
import com.mizore.dao.impl.OrderDetailDAOImpl;
import com.mizore.dao.impl.SalesDAOImpl;
import com.mizore.entity.dto.SalesRankDTO;
import com.mizore.entity.vo.SalesReportVO;
import jakarta.servlet.ServletOutputStream;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;

import com.mizore.service.SalesService;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDate;
import java.util.List;

public class SalesServiceImpl implements SalesService {


    private SalesDAO salesDAO = new SalesDAOImpl();

    private BookDAO bookDAO = new BookDAOImpl();

    private OrderDetailDAO orderDetailDAO = new OrderDetailDAOImpl();


    /**
     * 获取销量排行榜
     * @return
     */
    public List<SalesRankDTO> getList() {
        return salesDAO.getSalesList();
    }


    /**
     * 返回数据报表
     * @param response
     */
    public void exportExcel(HttpServletResponse response) {
        // 1. 设置时间范围：过去30天到昨天
        LocalDate dateBegin = LocalDate.now().minusDays(30);
        LocalDate dateEnd = LocalDate.now().minusDays(1);

        // 获取销售数据列表
        List<SalesRankDTO> salesList = salesDAO.getSalesList();

        // 2. 加载模板文件
        InputStream in = this.getClass().getClassLoader().getResourceAsStream("template/SalesReport.xlsx");

        try {
            if (in == null) {
                throw new RuntimeException("模板文件 [template/SalesReport.xlsx] 未找到，请检查 resources 目录结构");
            }

            XSSFWorkbook excel = new XSSFWorkbook(in);
            XSSFSheet sheet = excel.getSheet("sheet1");

            if (sheet == null) {
                throw new RuntimeException("Excel 模板中未找到名为 'sheet1' 的工作表");
            }

            // 3. 填充概览信息 (第4行，索引3)
            // A4 单元格显示统计时间范围
            XSSFRow infoRow = sheet.getRow(3); // 第4行
            if (infoRow != null) {
                XSSFCell cell = infoRow.getCell(0);
                if (cell == null) cell = infoRow.createCell(0);
                cell.setCellValue("统计周期：" + dateBegin + " 至 " + dateEnd);
            }

            // 4. 填充明细数据 (从第9行开始，索引8)
            // 注意：表头在索引7 (第8行)，数据从索引8 (第9行) 开始
            for (int i = 0; i < salesList.size(); i++) {
                SalesRankDTO dto = salesList.get(i);

                // 获取对应行 (索引 = 8 + i)
                XSSFRow row = sheet.getRow(8 + i);

                // 【关键修复】如果行不存在则创建 (防止模板行数不够或空行)
                if (row == null) {
                    row = sheet.createRow(8 + i);
                }

                // --- 严格匹配模板列结构 ---
                // B列 (索引1): 书名
                XSSFCell bookCell = row.getCell(1);
                if (bookCell == null) bookCell = row.createCell(1);
                bookCell.setCellValue(dto.getBookName());

                // C列 (索引2): 作者
                XSSFCell authorCell = row.getCell(2);
                if (authorCell == null) authorCell = row.createCell(2);
                authorCell.setCellValue(dto.getAuthor());

                // E列 (索引4): 销售额 (注意：D列是订单完成率，根据DTO字段调整)
                XSSFCell salesCell = row.getCell(4);
                if (salesCell == null) salesCell = row.createCell(4);
                // 防止 DTO 中数值为 null 导致报错
                salesCell.setCellValue(dto.getTotalSales() != null ? dto.getTotalSales() : 0);
            }

            // 5. 配置响应头 (重要：防止浏览器下载乱码)
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            String fileName = java.net.URLEncoder.encode("运营数据报表.xlsx", "UTF-8");
            response.setHeader("Content-Disposition", "attachment; filename=" + fileName);

            // 6. 写出文件并关闭流
            ServletOutputStream out = response.getOutputStream();
            excel.write(out);

            // 关闭资源 (try-with-resources 会自动处理，这里显式关闭也无妨)
            out.close();
            excel.close();
            in.close();

        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("导出 Excel 时发生IO异常", e);
        }
    }
}
