package com.mizore.entity.vo;

import com.mizore.entity.OrderDetail;
import com.mizore.entity.Orders;
import com.mizore.entity.User;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OrderVo implements Serializable {
    private Orders orders;
    private List<OrderDetail> orderDetailList;
    private User user;
}
