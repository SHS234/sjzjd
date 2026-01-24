package com.tencent.tdesign.mapper;

import com.tencent.tdesign.entity.SettlementEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface SettlementMapper {
    SettlementEntity selectById(@Param("id") Long id);
    
    List<SettlementEntity> selectByBoosterId(@Param("boosterId") Long boosterId);
    
    List<SettlementEntity> selectPage(@Param("limit") int limit, @Param("offset") int offset, 
                                      @Param("boosterId") Long boosterId, @Param("status") String status);
    
    long count(@Param("boosterId") Long boosterId, @Param("status") String status);
    
    int insert(SettlementEntity settlement);
    
    int update(SettlementEntity settlement);
}
