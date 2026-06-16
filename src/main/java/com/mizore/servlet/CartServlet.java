package com.mizore.servlet;

import com.mizore.entity.Book;
import com.mizore.entity.Cart;
import com.mizore.entity.User;
import com.mizore.service.BookService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private BookService bookService = new BookService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String action = request.getParameter("action");
        List<Cart> cartList = (List<Cart>) request.getSession().getAttribute("cart");
        if (cartList == null) {
            cartList = new ArrayList<>();
        }
        if ("add".equals(action)) {
            if (user == null) {
                request.getSession().setAttribute("loginMessage", "请先登录后再添加商品到购物车");
                response.sendRedirect(request.getContextPath() + "/user?action=login");
                return;
            }
            Long bookId = parseLong(request.getParameter("bookId"));
            int quantity = parseInt(request.getParameter("quantity"), 1);
            Book book = bookService.getById(bookId);
            if (book != null) {
                boolean found = false;
                for (Cart c : cartList) {
                    if (c.getBookId() != null && c.getBookId().equals(bookId)) {
                        c.setQuantity(c.getQuantity() + quantity);
                        c.setAmount(book.getPrice().multiply(BigDecimal.valueOf(c.getQuantity())));
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    Cart cart = Cart.builder()
                            .id(bookId)
                            .bookId(bookId)
                            .name(book.getName())
                            .image(book.getImage())
                            .price(book.getPrice())
                            .quantity(quantity)
                            .amount(book.getPrice().multiply(BigDecimal.valueOf(quantity)))
                            .build();
                    cartList.add(cart);
                }
            }
            request.getSession().setAttribute("cart", cartList);
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        } else if ("update".equals(action)) {
            Long bookId = parseLong(request.getParameter("bookId"));
            int quantity = parseInt(request.getParameter("quantity"), 1);
            Iterator<Cart> it = cartList.iterator();
            while (it.hasNext()) {
                Cart c = it.next();
                if (c.getBookId() != null && c.getBookId().equals(bookId)) {
                    if (quantity <= 0) {
                        it.remove();
                    } else {
                        c.setQuantity(quantity);
                        c.setAmount(c.getPrice().multiply(BigDecimal.valueOf(quantity)));
                    }
                    break;
                }
            }
            request.getSession().setAttribute("cart", cartList);
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        } else if ("remove".equals(action)) {
            Long bookId = parseLong(request.getParameter("bookId"));
            Iterator<Cart> it = cartList.iterator();
            while (it.hasNext()) {
                Cart c = it.next();
                if (c.getBookId() != null && c.getBookId().equals(bookId)) {
                    it.remove();
                    break;
                }
            }
            request.getSession().setAttribute("cart", cartList);
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        } else if ("clear".equals(action)) {
            request.getSession().removeAttribute("cart");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        BigDecimal total = BigDecimal.ZERO;
        for (Cart c : cartList) {
            total = total.add(c.getAmount());
        }
        request.setAttribute("cartList", cartList);
        request.setAttribute("totalAmount", total);
        request.getRequestDispatcher("/WEB-INF/views/front/cart.jsp").forward(request, response);
    }

    private int parseInt(String s, int defaultValue) {
        try {
            return s == null ? defaultValue : Integer.parseInt(s);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private Long parseLong(String s) {
        try {
            return s == null ? null : Long.parseLong(s);
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
