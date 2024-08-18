package com.project.eduapp.services.progressdetails;

import com.project.eduapp.dtos.OrderDetailDTO;
import com.project.eduapp.exceptions.DataNotFoundException;
import com.project.eduapp.models.ProgressDetail;

import java.util.List;

public interface IProgressDetailService {
    ProgressDetail createOrderDetail(OrderDetailDTO newOrderDetail) throws Exception;
    ProgressDetail getOrderDetail(Long id) throws DataNotFoundException;
    ProgressDetail updateOrderDetail(Long id, OrderDetailDTO newOrderDetailData)
            throws DataNotFoundException;
    void deleteById(Long id);
    List<ProgressDetail> findByOrderId(Long orderId);


}
