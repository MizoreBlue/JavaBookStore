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

//        TODO 一个订单对应多条订单详情，一条详情对应一本书籍

        List<OrderVo> orderVoList = new ArrayList<>();

//        获取所有的订单
        List<Orders> ordersList =  orderDAO.getAllOrders();

//        获得所有的订单Id
        List<Long> orderIds = ordersList.stream()
                .map(Orders::getId)
                .collect(Collectors.toList());

//        获取所有订单明细
        List<OrderDetail> allDetails = orderDetailDAO.getByOrderIds(orderIds);

        for (OrderDetail orderDetail : allDetails) {
//            根据bookId查询书籍
            Book book = bookDAO.findById(orderDetail.getBookId());

//            设置书籍对象
            orderDetail.setBook(book);
        }

//        按照订单Id对订单明细进行分组,便于查找
        Map<Long, List<OrderDetail>> idToDetaiMap = allDetails.stream()
                .collect(Collectors.groupingBy(OrderDetail::getOrderId));

//        组装 OrderVo
        for(Orders orders : ordersList) {
            OrderVo orderVo = new OrderVo();
//            设置订单详信息
            orderVo.setOrders(orders);

//            获取一条定单对应的订单明细集合
            List<OrderDetail> orderDetails = idToDetaiMap.getOrDefault(orders.getId(), Collections.emptyList());

            orderVo.setOrderDetailList(orderDetails);
            orderVoList.add(orderVo);
        }

        return orderVoList;
    }
}
