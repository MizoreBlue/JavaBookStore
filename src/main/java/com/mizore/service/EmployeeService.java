package com.mizore.service;

import com.mizore.dao.EmployeeDAO;
import com.mizore.entity.Employee;
import com.mizore.utils.PageResult;

public class EmployeeService {

    private EmployeeDAO employeeDAO = ServiceFactory.getEmployeeDAO();

    public Employee login(String username, String password) {
        Employee employee = employeeDAO.getByUsername(username);
        if (employee != null && password != null && password.equals(employee.getPassword())) {
            return employee;
        }
        return null;
    }

    public Employee getById(Long id) {
        return employeeDAO.getById(id);
    }

    public PageResult<Employee> page(int page, int pageSize) {
        if (page < 1) page = 1;
        return PageResult.of(employeeDAO.page(page, pageSize), employeeDAO.count(), page, pageSize);
    }
}
