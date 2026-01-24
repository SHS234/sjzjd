package com.tencent.tdesign.controller;

import com.tencent.tdesign.annotation.RepeatSubmit;
import com.tencent.tdesign.entity.BoosterEntity;
import com.tencent.tdesign.service.BoosterService;
import com.tencent.tdesign.vo.ApiResponse;
import com.tencent.tdesign.vo.PageResult;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/booster")
public class BoosterController {
    private final BoosterService service;

    public BoosterController(BoosterService service) {
        this.service = service;
    }

    @GetMapping("/list")
    public ApiResponse<PageResult<BoosterEntity>> list(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String keyword) {
        return ApiResponse.success(service.list(keyword, page, size));
    }

    @GetMapping("/detail")
    public ApiResponse<BoosterEntity> detail(@RequestParam Long id) {
        return ApiResponse.success(service.get(id));
    }

    @PostMapping("/create")
    @RepeatSubmit
    public ApiResponse<BoosterEntity> create(@RequestBody BoosterEntity booster) {
        return ApiResponse.success(service.create(booster));
    }

    @PostMapping("/update")
    @RepeatSubmit
    public ApiResponse<BoosterEntity> update(@RequestBody BoosterEntity booster) {
        return ApiResponse.success(service.update(booster.getId(), booster));
    }

    @PostMapping("/delete")
    @RepeatSubmit
    public ApiResponse<Boolean> delete(@RequestBody Map<String, Long> payload) {
        Long id = payload.get("id");
        return ApiResponse.success(service.delete(id));
    }
}
