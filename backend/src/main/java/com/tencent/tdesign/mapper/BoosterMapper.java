package com.tencent.tdesign.mapper;

import com.tencent.tdesign.entity.BoosterEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface BoosterMapper {
    BoosterEntity selectById(Long id);
    
    List<BoosterEntity> selectPage(@Param("keyword") String keyword, 
                                 @Param("limit") int limit, 
                                 @Param("offset") int offset);
                                 
    long count(@Param("keyword") String keyword);
    
    int insert(BoosterEntity booster);
    
    int update(BoosterEntity booster);
    
    int deleteById(Long id);
}
