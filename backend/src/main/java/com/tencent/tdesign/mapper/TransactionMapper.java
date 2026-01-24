package com.tencent.tdesign.mapper;

import com.tencent.tdesign.entity.TransactionEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface TransactionMapper {
    List<TransactionEntity> selectPage(@Param("limit") int limit, @Param("offset") int offset, 
                                       @Param("boosterId") Long boosterId, @Param("type") String type);
                                       
    long count(@Param("boosterId") Long boosterId, @Param("type") String type);
    
    int insert(TransactionEntity transaction);
}
