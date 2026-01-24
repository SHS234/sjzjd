package com.tencent.tdesign.controller;

import com.tencent.tdesign.dto.AfterSalesApplyRequest;
import com.tencent.tdesign.dto.AfterSalesResolveRequest;
import com.tencent.tdesign.entity.AfterSalesEntity;
import com.tencent.tdesign.service.AfterSalesService;
import com.tencent.tdesign.vo.ApiResponse;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/after-sales")
public class AfterSalesController {

    private final AfterSalesService afterSalesService;

    public AfterSalesController(AfterSalesService afterSalesService) {
        this.afterSalesService = afterSalesService;
    }

    @PostMapping("/apply")
    public ApiResponse<Void> apply(@RequestBody AfterSalesApplyRequest req) {
        afterSalesService.apply(req);
        return ApiResponse.success(null);
    }

    @GetMapping("/detail/{orderId}")
    public ApiResponse<AfterSalesEntity> detail(@PathVariable Long orderId) {
        return ApiResponse.success(afterSalesService.detail(orderId));
    }

    @GetMapping("/list")
    public ApiResponse<java.util.List<AfterSalesEntity>> list(
        @RequestParam(required = false) String status,
        @RequestParam(required = false) Long initiatorId
    ) {
        return ApiResponse.success(afterSalesService.list(status, initiatorId));
    }

    @PostMapping("/resolve")
    public ApiResponse<Void> resolve(@RequestBody AfterSalesResolveRequest req) {
        afterSalesService.resolve(req);
        return ApiResponse.success(null);
    }

    @DeleteMapping("/{id}")
    public ApiResponse<Void> delete(@PathVariable Long id) {
        afterSalesService.delete(id);
        return ApiResponse.success(null);
    }
}
