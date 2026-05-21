package com.mizore.entity.vo;

import com.mizore.entity.Book;
import com.mizore.entity.OrderDetail;
import com.mizore.entity.Orders;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class OrderVo {

    //    一条订单的详细信息 下单时间都在这里
    private Orders orders;


    //    订单对应的多本书籍
    private List<OrderDetail> orderDetailList;

}
