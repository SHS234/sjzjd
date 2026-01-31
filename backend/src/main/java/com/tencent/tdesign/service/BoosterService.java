package com.tencent.tdesign.service;

import com.tencent.tdesign.entity.BoosterEntity;
import com.tencent.tdesign.mapper.BoosterMapper;
import com.tencent.tdesign.vo.PageResult;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
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
        require(booster.getName(), "name");
        require(booster.getPhone(), "phone");
        require(booster.getRank(), "rank");
        require(booster.getDevice(), "device");
        booster.setStatus("OFFLINE");
        LocalDateTime now = LocalDateTime.now();
        booster.setCreatedAt(now);
        booster.setUpdatedAt(now);
        mapper.insert(booster);
        return booster;
    }

    public BoosterEntity update(Long id, BoosterEntity booster) {
        booster.setId(id);
        require(booster.getName(), "name");
        require(booster.getPhone(), "phone");
        require(booster.getRank(), "rank");
        require(booster.getDevice(), "device");
        booster.setUpdatedAt(LocalDateTime.now());
        mapper.update(booster);
        return mapper.selectById(id);
    }

    public boolean delete(Long id) {
        return mapper.deleteById(id) > 0;
    }

    public BoosterEntity get(Long id) {
        return mapper.selectById(id);
    }

    private void require(String value, String field) {
        if (value == null || value.isBlank()) {
            throw new IllegalArgumentException("字段 " + field + " 不能为空");
        }
    }
}
