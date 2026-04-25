package com.mizore.servlet.admin;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mizore.entity.Book;
import com.mizore.service.BookService;
import com.mizore.service.impl.BookServiceImpl;
import com.mizore.utils.Result;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig; // 1. 导入注解
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part; // 导入Part用于接收文件

import java.io.IOException;
import java.math.BigDecimal; // 用于处理价格
import java.util.List;

@WebServlet(urlPatterns = "/backend/product/*")
@MultipartConfig // 2. 【关键修复】添加此注解以支持文件上传 (multipart/form-data)
public class ProductServlet extends HttpServlet {

    private BookService bookService = new BookServiceImpl();
    private ObjectMapper objectMapper = new ObjectMapper();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.contains("/list")) {
            // 查询列表逻辑
            // 注意：如果Book表中有日期等复杂类型，可能需要处理JSON序列化问题
            List<Book> products = bookService.findAllBooks();
            req.setAttribute("products", products);
            req.getRequestDispatcher("/WEB-INF/views/admin/product_list.jsp").forward(req, resp);
        } else if (uri.contains("/add")) {
            // 跳转到添加页面
            req.getRequestDispatcher("/WEB-INF/views/admin/product_add.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 设置请求体编码（必须在获取参数之前）
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");

        String uri = req.getRequestURI();

        if (uri.contains("/add")) {
            try {
                // 3. 【逻辑修复】修正 Builder 的链式调用，每个字段对应各自的 setter
                Book book = Book.builder()
                        .name(req.getParameter("name"))
                        .author(req.getParameter("author")) // 注意：你的JSP里似乎没有author字段，如果数据库非空可能会报错
                        .description(req.getParameter("description"))
                        .category(req.getParameter("category"))
                        .price(new BigDecimal(req.getParameter("price"))) // 价格通常用 BigDecimal
                        .stock(Integer.parseInt(req.getParameter("stock"))) // 库存转为 Integer
                        .build();

                // 4. 处理图片上传 (虽然你暂时不实现，但必须接收这个Part，否则数据会丢失)
                Part imagePart = req.getPart("image");
                // 这里可以获取文件名 imagePart.getSubmittedFileName()
                // 既然暂时不实现上传，我们可以先不处理，或者给book设置一个默认图片路径
                // book.setImage("default.jpg");

                // 5. 调用业务层保存
                boolean flag = bookService.insert(book);

                Result<String> result;
                if (flag) {
                    result = Result.success("商品添加成功");
                } else {
                    result = Result.error("添加失败，未知错误");
                }

                // 返回 JSON
                String json = objectMapper.writeValueAsString(result);
                resp.getWriter().write(json);

            } catch (Exception e) {
                e.printStackTrace();
                // 发生异常时返回错误信息
                Result<String> result = Result.error("系统异常：" + e.getMessage());
                String json = objectMapper.writeValueAsString(result);
                resp.getWriter().write(json);
            }
        }
    }
}