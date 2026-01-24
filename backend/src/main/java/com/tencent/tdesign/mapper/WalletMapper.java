package com.tencent.tdesign.mapper;

import com.tencent.tdesign.entity.WalletEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface WalletMapper {
    WalletEntity selectByBoosterId(@Param("boosterId") Long boosterId);

    WalletEntity selectByUserId(@Param("userId") Long userId);
    
    int insert(WalletEntity wallet);
    
    int update(WalletEntity wallet);
}
