package com.project.eduapp.services.progressdetails;

import com.project.eduapp.dtos.OrderDetailDTO;
import com.project.eduapp.exceptions.DataNotFoundException;
import com.project.eduapp.models.Progress;
import com.project.eduapp.models.ProgressDetail;
import com.project.eduapp.models.Lesson;
import com.project.eduapp.repositories.ProgressDetailRepository;
import com.project.eduapp.repositories.ProgressRepository;
import com.project.eduapp.repositories.LessonRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Service
public class ProgressDetailService implements IProgressDetailService {
    private final ProgressRepository orderRepository;
    private final ProgressDetailRepository orderDetailRepository;
    private final LessonRepository productRepository;
    @Override
    @Transactional
    public ProgressDetail createOrderDetail(OrderDetailDTO orderDetailDTO) throws Exception {
        //tìm xem orderId có tồn tại ko
        Progress order = orderRepository.findById(orderDetailDTO.getOrderId())
                .orElseThrow(() -> new DataNotFoundException(
                        "Cannot find Order with id : "+orderDetailDTO.getOrderId()));
        // Tìm Product theo id
        Lesson product = productRepository.findById(orderDetailDTO.getProductId())
                .orElseThrow(() -> new DataNotFoundException(
                        "Cannot find product with id: " + orderDetailDTO.getProductId()));
        ProgressDetail orderDetail = ProgressDetail.builder()
                .order(order)
                .lesson(product)
                .progress(orderDetailDTO.getProgress())
                .maxScore(orderDetailDTO.getPrice())
                .totalScore(orderDetailDTO.getTotalScore())
                .color(orderDetailDTO.getColor())
                .build();
        //lưu vào db
        return orderDetailRepository.save(orderDetail);
    }

    @Override
    public ProgressDetail getOrderDetail(Long id) throws DataNotFoundException {
        return orderDetailRepository.findById(id)
                .orElseThrow(()->new DataNotFoundException("Cannot find OrderDetail with id: "+id));
    }

    @Override
    @Transactional
    public ProgressDetail updateOrderDetail(Long id, OrderDetailDTO orderDetailDTO)
            throws DataNotFoundException {
        //tìm xem order detail có tồn tại ko đã
        ProgressDetail existingOrderDetail = orderDetailRepository.findById(id)
                .orElseThrow(() -> new DataNotFoundException("Cannot find order detail with id: "+id));
        Progress existingOrder = orderRepository.findById(orderDetailDTO.getOrderId())
                .orElseThrow(() -> new DataNotFoundException("Cannot find order with id: "+id));
        Lesson existingProduct = productRepository.findById(orderDetailDTO.getProductId())
                .orElseThrow(() -> new DataNotFoundException(
                        "Cannot find product with id: " + orderDetailDTO.getProductId()));
        existingOrderDetail.setMaxScore(orderDetailDTO.getPrice());
        existingOrderDetail.setProgress(orderDetailDTO.getProgress());
        existingOrderDetail.setTotalScore(orderDetailDTO.getTotalScore());
        existingOrderDetail.setColor(orderDetailDTO.getColor());
        existingOrderDetail.setOrder(existingOrder);
        existingOrderDetail.setLesson(existingProduct);
        return orderDetailRepository.save(existingOrderDetail);
    }

    @Override
    @Transactional
    public void deleteById(Long id) {
        orderDetailRepository.deleteById(id);
    }

    @Override
    public List<ProgressDetail> findByOrderId(Long orderId) {
        return orderDetailRepository.findByOrderId(orderId);
    }
}
