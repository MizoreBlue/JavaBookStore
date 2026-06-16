package com.mizore.service;

import com.mizore.dao.BookDAO;
import com.mizore.dao.CategoryDAO;
import com.mizore.dao.EmployeeDAO;
import com.mizore.dao.OrderDAO;
import com.mizore.dao.OrderDetailDAO;
import com.mizore.dao.SalesDAO;
import com.mizore.dao.UserDAO;
import com.mizore.dao.impl.BookDAOImpl;
import com.mizore.dao.impl.CategoryDAOImpl;
import com.mizore.dao.impl.EmployeeDAOImpl;
import com.mizore.dao.impl.OrderDAOImpl;
import com.mizore.dao.impl.OrderDetailDAOImpl;
import com.mizore.dao.impl.SalesDAOImpl;
import com.mizore.dao.impl.UserDAOImpl;

public class ServiceFactory {

    private static final UserDAO userDAO = new UserDAOImpl();
    private static final BookDAO bookDAO = new BookDAOImpl();
    private static final CategoryDAO categoryDAO = new CategoryDAOImpl();
    private static final OrderDAO orderDAO = new OrderDAOImpl();
    private static final OrderDetailDAO orderDetailDAO = new OrderDetailDAOImpl();
    private static final EmployeeDAO employeeDAO = new EmployeeDAOImpl();
    private static final SalesDAO salesDAO = new SalesDAOImpl();

    public static UserDAO getUserDAO() {
        return userDAO;
    }

    public static BookDAO getBookDAO() {
        return bookDAO;
    }

    public static CategoryDAO getCategoryDAO() {
        return categoryDAO;
    }

    public static OrderDAO getOrderDAO() {
        return orderDAO;
    }

    public static OrderDetailDAO getOrderDetailDAO() {
        return orderDetailDAO;
    }

    public static EmployeeDAO getEmployeeDAO() {
        return employeeDAO;
    }

    public static SalesDAO getSalesDAO() {
        return salesDAO;
    }
}
