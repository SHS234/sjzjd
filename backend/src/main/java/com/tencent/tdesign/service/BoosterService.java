package com.tencent.tdesign.service;

import com.tencent.tdesign.entity.BoosterEntity;
import com.tencent.tdesign.mapper.BoosterMapper;
import com.tencent.tdesign.vo.PageResult;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class BoosterService {
    private final BoosterMapper mapper;

    public BoosterService(BoosterMapper mapper) {
        this.mapper = mapper;
    }

    public PageResult<BoosterEntity> list(String keyword, int page, int size) {
        int offset = (page - 1) * size;
        List<BoosterEntity> list = mapper.selectPage(keyword, size, offset);
        long total = mapper.count(keyword);
        return new PageResult<>(list, total);
    }

    public BoosterEntity create(BoosterEntity booster) {
        booster.setStatus("OFFLINE");
        mapper.insert(booster);
        return booster;
    }

    public BoosterEntity update(Long id, BoosterEntity booster) {
        booster.setId(id);
        mapper.update(booster);
        return mapper.selectById(id);
    }

    public boolean delete(Long id) {
        return mapper.deleteById(id) > 0;
    }

    public BoosterEntity get(Long id) {
        return mapper.selectById(id);
    }
}
