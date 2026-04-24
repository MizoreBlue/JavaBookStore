package com.mizore.servlet.user;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mizore.entity.User;
import com.mizore.service.UserService;
import com.mizore.service.impl.UserServiceImpl;
import com.mizore.utils.Result;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet(urlPatterns = "/user/*")
public class UserServlet extends HttpServlet {


    private UserService userService = new UserServiceImpl();

    // Jackson 对象映射器，用于将对象转为 JSON 字符串
    private ObjectMapper objectMapper = new ObjectMapper();


    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

         String uri = req.getRequestURI();

//        响应注册页面
        if (uri.contains("/register")) {
            req.getRequestDispatcher("/WEB-INF/views/client/register.jsp").forward(req, resp);
        }


//        响应登录界面
        if (uri.contains("/login")) {
            req.getRequestDispatcher("/WEB-INF/views/client/login.jsp").forward(req, resp);
        }

        if (uri.contains("/logout")) {
            // 销毁 Session
            req.getSession().invalidate();
            // 重定向回首页
            resp.sendRedirect(req.getContextPath() + "/index");
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 设置请求编码，防止中文乱码
        req.setCharacterEncoding("UTF-8");
        // 2. 设置响应编码和内容类型
        resp.setContentType("application/json;charset=UTF-8");

        String uri = req.getRequestURI();

        // 请求类型为post 即使路径相同进到的方法也不同
        if (uri.contains("register")) {
            User user = User.builder()
                    .username(req.getParameter("username"))
                    .password(req.getParameter("password"))
                    .phone(req.getParameter("phone"))
                    .email(req.getParameter("email"))
                    .sex(req.getParameter("sex"))
                    .createTime(LocalDateTime.now())
                    .build();

            boolean isSuccess =  userService.register(user);

            Result<String> result;

            if (isSuccess) {
                // 成功：返回统一结果
                result = Result.success("注册成功，请登录");
            } else result = Result.error("注册失败，用户名可能已经存在");

            // 将 result 对象转为 JSON 字符串: {"code":1, "msg":"...", "data":"..."}
            String json = objectMapper.writeValueAsString(result);
            resp.getWriter().write(json);
        }


//        用户登陆提交用户名和密码
        if (uri.contains("login")) {
            User user = User.builder()
                    .username(req.getParameter("username"))
                    .password(req.getParameter("password"))
                    .build();
//            参数封装
//            调用service 层
            boolean result = userService.login(user);
            if (result) {
//                比对成功返回主页，将用户信息存贮到session
                user.setPassword(null);
                req.getSession().setAttribute("user", user);
                resp.sendRedirect("/index");
            }else {
//                登录失败 提示密码错误
                // 注意：这里存入 session 是为了在重定向后还能获取到刚才输入的用户名，用于回显
                req.getSession().setAttribute("loginError", "用户名或密码错误");
                // 浏览器会发起一个新的 GET 请求，地址栏变为 /user/login
                resp.sendRedirect(req.getContextPath() + "/user/login");
            }
        }
    }

}