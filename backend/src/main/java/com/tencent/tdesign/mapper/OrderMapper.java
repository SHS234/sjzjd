package com.tencent.tdesign.mapper;

import com.tencent.tdesign.entity.OrderEntity;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface OrderMapper {
    OrderEntity selectById(@Param("id") Long id);
    OrderEntity selectByOrderNo(@Param("orderNo") String orderNo);
    
    List<OrderEntity> selectPage(
        @Param("keyword") String keyword, 
        @Param("status") String status, 
        @Param("offset") int offset, 
        @Param("limit") int limit
    );
    
    long count(
        @Param("keyword") String keyword, 
        @Param("status") String status
    );

    java.math.BigDecimal sumAmountByStatus(@Param("status") String status);
    
    int insert(OrderEntity entity);
    int update(OrderEntity entity);
    int deleteById(@Param("id") Long id);
    
    long countByBoosterIdAndStatus(@Param("boosterId") Long boosterId, @Param("status") String status);
}
