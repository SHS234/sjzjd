package com.tencent.tdesign.mapper;

import com.tencent.tdesign.entity.AfterSalesEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;

@Mapper
public interface AfterSalesMapper {
    int insert(AfterSalesEntity entity);
    int update(AfterSalesEntity entity);
    AfterSalesEntity selectById(@Param("id") Long id);
    int delete(@Param("id") Long id);
    AfterSalesEntity selectByOrderId(@Param("orderId") Long orderId);
    List<AfterSalesEntity> selectList(@Param("status") String status, @Param("initiatorId") Long initiatorId);
    BigDecimal sumRefundAmount();
}
