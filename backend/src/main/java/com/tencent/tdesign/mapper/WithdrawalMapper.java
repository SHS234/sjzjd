package com.tencent.tdesign.mapper;

import com.tencent.tdesign.entity.WithdrawalEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface WithdrawalMapper {
    WithdrawalEntity selectById(@Param("id") Long id);
    
    List<WithdrawalEntity> selectPage(@Param("limit") int limit, @Param("offset") int offset, 
                                      @Param("boosterId") Long boosterId, @Param("status") String status);
                                      
    long count(@Param("boosterId") Long boosterId, @Param("status") String status);
    
    int insert(WithdrawalEntity withdrawal);
    
    int update(WithdrawalEntity withdrawal);
}
