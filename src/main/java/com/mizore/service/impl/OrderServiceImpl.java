package com.mizore.service.impl;

import com.mizore.dao.BookDAO;
import com.mizore.dao.OrderDAO;
import com.mizore.dao.OrderDetailDAO;
import com.mizore.dao.impl.BookDAOImpl;
import com.mizore.dao.impl.OrderDAOImpl;
import com.mizore.dao.impl.OrderDetailDAOImpl;
import com.mizore.entity.Book;
import com.mizore.entity.OrderDetail;
import com.mizore.entity.Orders;
import com.mizore.entity.vo.OrderVo;
import com.mizore.service.BookService;
import com.mizore.service.OrderService;
import org.springframework.beans.BeanUtils;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class OrderServiceImpl implements OrderService {


    private BookDAO bookDAO = new BookDAOImpl();

    private OrderDAO orderDAO = new OrderDAOImpl();

    private OrderDetailDAO orderDetailDAO = new OrderDetailDAOImpl();

    /**
     * 查询订单列表
     * @return 所有订单集合
     */
    public List<OrderVo> getAllOrders(){

        List<OrderVo> orderVoList = new ArrayList<>();

//        获取所有的订单
        List<Orders> ordersList =  orderDAO.getAllOrders();

//        获得所有的订单Id
        List<String> orderIds = ordersList.stream()
                .map(Orders::getId)
                .collect(Collectors.toList());

//        批量查询所有订单明细
        List<OrderDetail> allDetails = orderDetailDAO.getByOrderIds(orderIds);

//        按照订单Id分组,便于查找
        Map<String, List<OrderDetail>> detailMap = allDetails.stream()
                .collect(Collectors.groupingBy(OrderDetail::getOrderId));

//        组装 OrderVo
        for(Orders orders : ordersList) {
            OrderVo orderVo = new OrderVo();
            BeanUtils.copyProperties(orders, orderVo);
            List<OrderDetail> orderDetails = detailMap.getOrDefault(orders.getId(), Collections.emptyList());


//            TODO 待修改 返回所有订单详细信息
            orderVo.setOrderDetailList(orderDetails);
            orderVoList.add(orderVo);
        }

//        根据订单Id批量查询

        return List.of();
    }
}
