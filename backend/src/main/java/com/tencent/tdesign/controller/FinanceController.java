package com.tencent.tdesign.controller;

import com.tencent.tdesign.entity.SettlementEntity;
import com.tencent.tdesign.entity.TransactionEntity;
import com.tencent.tdesign.entity.WalletEntity;
import com.tencent.tdesign.service.FinanceService;
import com.tencent.tdesign.vo.ApiResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import cn.dev33.satoken.stp.StpUtil;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/finance")
public class FinanceController {

    @Autowired
    private FinanceService financeService;

    @GetMapping("/wallet")
    public ApiResponse<WalletEntity> getMyWallet() {
        // For simplicity, assuming current user is booster
        // In real app, check role
        long userId = StpUtil.getLoginIdAsLong();
        return ApiResponse.success(financeService.getWallet(userId));
    }

    @GetMapping("/settlements")
    public ApiResponse<Map<String, Object>> getSettlements(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String status) {
        long userId = StpUtil.getLoginIdAsLong();
        // If admin, can see all? For now, let's say this is for booster view
        // Or add logic to check role
        Long boosterId = userId; // Simplification
        
        List<SettlementEntity> list = financeService.getSettlements(page, size, boosterId, status);
        long total = financeService.countSettlements(boosterId, status);
        
        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("total", total);
        return ApiResponse.success(result);
    }

    @GetMapping("/transactions")
    public ApiResponse<Map<String, Object>> getTransactions(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String type) {
        long userId = StpUtil.getLoginIdAsLong();
        List<TransactionEntity> list = financeService.getTransactions(page, size, userId, type);
        long total = financeService.countTransactions(userId, type);
        
        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("total", total);
        return ApiResponse.success(result);
    }
    
    @PostMapping("/settlements/{id}/settle")
    public ApiResponse<Void> manualSettle(@PathVariable Long id) {
        financeService.settle(id);
        return ApiResponse.success(null);
    }
}
