package com.tencent.tdesign.mapper;

import com.tencent.tdesign.entity.OrderTimelineEntity;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface OrderTimelineMapper {
    List<OrderTimelineEntity> selectByOrderId(@Param("orderId") Long orderId);
    
    int insert(OrderTimelineEntity entity);
}
