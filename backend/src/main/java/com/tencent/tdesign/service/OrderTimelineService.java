package com.tencent.tdesign.service;

import com.tencent.tdesign.entity.OrderTimelineEntity;
import com.tencent.tdesign.mapper.OrderTimelineMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class OrderTimelineService {

    private final OrderTimelineMapper mapper;

    public OrderTimelineService(OrderTimelineMapper mapper) {
        this.mapper = mapper;
    }

    public List<OrderTimelineEntity> listByOrder(Long orderId) {
        return mapper.selectByOrderId(orderId);
    }

    @Transactional
    public void log(Long orderId, Long operatorId, String operatorName, String action, String content, String metaData) {
        OrderTimelineEntity entity = new OrderTimelineEntity();
        entity.setOrderId(orderId);
        entity.setOperatorId(operatorId);
        entity.setOperatorName(operatorName);
        entity.setAction(action);
        entity.setContent(content);
        entity.setMetaData(metaData);
        entity.setCreatedAt(LocalDateTime.now());
        mapper.insert(entity);
    }
}
