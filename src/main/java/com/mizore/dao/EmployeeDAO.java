package com.mizore.dao;

import com.mizore.entity.Employee;

import java.util.List;

public interface EmployeeDAO {
    Employee getByUsername(String username);
    Employee getById(Long id);
    List<Employee> page(int page, int pageSize);
    long count();
}
