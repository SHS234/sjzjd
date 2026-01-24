package com.tencent.tdesign.controller;

import com.tencent.tdesign.dto.OrderUpsertRequest;
import com.tencent.tdesign.entity.OrderEntity;
import com.tencent.tdesign.service.OrderService;
import com.tencent.tdesign.vo.ApiResponse;
import com.tencent.tdesign.vo.PageResult;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.*;

import com.tencent.tdesign.entity.OrderTimelineEntity;
import com.tencent.tdesign.service.OrderTimelineService;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/order")
public class OrderController {
    
    private final OrderService service;
    private final OrderTimelineService timelineService;

    public OrderController(OrderService service, OrderTimelineService timelineService) {
        this.service = service;
        this.timelineService = timelineService;
    }

    @GetMapping
    public ApiResponse<PageResult<OrderEntity>> list(
        @RequestParam(defaultValue = "1") int page,
        @RequestParam(defaultValue = "10") int size,
        @RequestParam(required = false) String keyword,
        @RequestParam(required = false) String status
    ) {
        return ApiResponse.success(service.page(keyword, status, page, size));
    }

    @GetMapping("/summary")
    public ApiResponse<Map<String, Object>> summary() {
        Map<String, Object> result = new HashMap<>();
        result.put("totalIncome", service.sumAmountByStatus("COMPLETED"));
        return ApiResponse.success(result);
    }

    @GetMapping("/{id:\\d+}")
    public ApiResponse<OrderEntity> detail(@PathVariable Long id) {
        return ApiResponse.success(service.detail(id));
    }

    @GetMapping("/no/{orderNo}")
    public ApiResponse<OrderEntity> getByOrderNo(@PathVariable String orderNo) {
        return ApiResponse.success(service.getByOrderNo(orderNo));
    }

    @GetMapping("/{id:\\d+}/timeline")
    public ApiResponse<List<OrderTimelineEntity>> timeline(@PathVariable Long id) {
        return ApiResponse.success(timelineService.listByOrder(id));
    }

    @PostMapping
    public ApiResponse<OrderEntity> create(@RequestBody @Valid OrderUpsertRequest req) {
        return ApiResponse.success(service.create(req));
    }
    
    @PutMapping("/{id:\\d+}")
    public ApiResponse<OrderEntity> update(@PathVariable Long id, @RequestBody @Valid OrderUpsertRequest req) {
        return ApiResponse.success(service.update(id, req));
    }

    @DeleteMapping("/{id:\\d+}")
    public ApiResponse<Void> delete(@PathVariable Long id) {
        service.delete(id);
        return ApiResponse.success(null);
    }

    @PostMapping("/{id:\\d+}/assign")
    public ApiResponse<Void> assign(@PathVariable Long id, @RequestBody Map<String, Object> payload) {
        Object boosterIdObj = payload.get("boosterId");
        if (boosterIdObj == null) {
             throw new IllegalArgumentException("Booster ID is required");
        }
        Long boosterId = Long.valueOf(boosterIdObj.toString());
        service.assign(id, boosterId);
        return ApiResponse.success(null);
    }

    @PostMapping("/{id:\\d+}/complete")
    public ApiResponse<Void> complete(@PathVariable Long id) {
        service.complete(id);
        return ApiResponse.success(null);
    }
}
