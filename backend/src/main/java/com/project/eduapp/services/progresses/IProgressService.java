package com.project.eduapp.services.progresses;

import com.project.eduapp.dtos.OrderDTO;
import com.project.eduapp.exceptions.DataNotFoundException;
import com.project.eduapp.models.Progress;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface IProgressService {
    Progress createOrder(OrderDTO orderDTO) throws Exception;
    Progress getOrder(Long id);
    Progress updateOrder(Long id, OrderDTO orderDTO) throws DataNotFoundException;
    void deleteOrder(Long id);
    List<Progress> findByUserId(Long userId);
    Page<Progress> getOrdersByKeyword(String keyword, Pageable pageable);
}
