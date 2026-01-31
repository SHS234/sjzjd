package com.tencent.tdesign.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tencent.tdesign.dto.AfterSalesApplyRequest;
import com.tencent.tdesign.dto.AfterSalesResolveRequest;
import com.tencent.tdesign.entity.AfterSalesEntity;
import com.tencent.tdesign.entity.OrderEntity;
import com.tencent.tdesign.entity.WalletEntity;
import com.tencent.tdesign.mapper.AfterSalesMapper;
import com.tencent.tdesign.mapper.OrderMapper;
import com.tencent.tdesign.mapper.WalletMapper;
import cn.dev33.satoken.stp.StpUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Service
public class AfterSalesService {

    private final AfterSalesMapper afterSalesMapper;
    private final OrderMapper orderMapper;
    private final WalletMapper walletMapper;
    private final OrderTimelineService timelineService;
    private final ObjectMapper objectMapper;

    public AfterSalesService(AfterSalesMapper afterSalesMapper, 
                             OrderMapper orderMapper, 
                             WalletMapper walletMapper,
                             OrderTimelineService timelineService,
                             ObjectMapper objectMapper) {
        this.afterSalesMapper = afterSalesMapper;
        this.orderMapper = orderMapper;
        this.walletMapper = walletMapper;
        this.timelineService = timelineService;
        this.objectMapper = objectMapper;
    }

    @Transactional
    public void apply(AfterSalesApplyRequest req) {
        OrderEntity order = orderMapper.selectById(req.getOrderId());
        if (order == null) {
            throw new RuntimeException("订单不存在");
        }
        
        // Ensure order is not already in after-sales or closed
        AfterSalesEntity existing = afterSalesMapper.selectByOrderId(req.getOrderId());
        if (existing != null && !"CLOSED".equals(existing.getStatus()) && !"RESOLVED".equals(existing.getStatus())) {
            throw new RuntimeException("该订单已存在进行中的售后申请");
        }

        // Lock the order
        order.setStatus("LOCKED");
        order.setUpdatedAt(LocalDateTime.now());
        orderMapper.update(order);

        // Create After Sales record
        AfterSalesEntity entity = new AfterSalesEntity();
        entity.setOrderId(req.getOrderId());
        entity.setInitiatorId(StpUtil.getLoginIdAsLong());
        entity.setReasonType(req.getReasonType());
        entity.setDescription(req.getDescription());
        try {
            entity.setEvidenceImgs(objectMapper.writeValueAsString(req.getEvidenceImgs()));
        } catch (Exception e) {
            entity.setEvidenceImgs("[]");
        }
        entity.setStatus("PENDING");
        entity.setCreatedAt(LocalDateTime.now());
        entity.setUpdatedAt(LocalDateTime.now());
        
        afterSalesMapper.insert(entity);

        // Log timeline
        timelineService.log(order.getId(), StpUtil.getLoginIdAsLong(), "用户/打手", "申请售后", "发起售后申请，资金已冻结", null);
    }

    public AfterSalesEntity detail(Long orderId) {
        return afterSalesMapper.selectByOrderId(orderId);
    }

    public java.util.List<AfterSalesEntity> list(String status, Long initiatorId) {
        return afterSalesMapper.selectList(status, initiatorId);
    }

    public java.math.BigDecimal sumRefundAmount() {
        java.math.BigDecimal total = afterSalesMapper.sumRefundAmount();
        return total == null ? java.math.BigDecimal.ZERO : total;
    }

    @Transactional
    public void resolve(AfterSalesResolveRequest req) {
        AfterSalesEntity entity = afterSalesMapper.selectById(req.getAfterSalesId());
        if (entity == null) {
            throw new RuntimeException("售后单不存在");
        }

        OrderEntity order = orderMapper.selectById(entity.getOrderId());
        if (order == null) {
            throw new RuntimeException("关联订单不存在");
        }

        // Update After Sales
        entity.setRefundAmount(req.getRefundAmount());
        entity.setBoosterIncome(req.getBoosterIncome());
        entity.setPenaltyAmount(req.getPenaltyAmount());
        entity.setAdminRemark(req.getAdminRemark());
        entity.setStatus("RESOLVED");
        entity.setResolvedAt(LocalDateTime.now());
        entity.setUpdatedAt(LocalDateTime.now());
        afterSalesMapper.update(entity);

        // Update Order Status
        order.setStatus("CLOSED"); // As requested: "售后关闭"
        order.setUpdatedAt(LocalDateTime.now());
        orderMapper.update(order);

        // Execute Money Transfer
        // 1. Refund to Customer
        if (req.getRefundAmount().compareTo(BigDecimal.ZERO) > 0) {
            WalletEntity customerWallet = walletMapper.selectByUserId(order.getCustomerId());
            if (customerWallet != null) {
                customerWallet.setBalance(customerWallet.getBalance().add(req.getRefundAmount()));
                walletMapper.update(customerWallet);
                // TODO: Add transaction log
            }
        }

        // 2. Income to Booster (and Penalty deduction if applicable, though usually penalty is just less income)
        // If penalty is separate (e.g. from deposit), we need to handle it. 
        // Here we assume Booster Income is the final amount to be added to balance.
        if (req.getBoosterIncome().compareTo(BigDecimal.ZERO) > 0) {
            WalletEntity boosterWallet = walletMapper.selectByUserId(order.getBoosterId());
            if (boosterWallet != null) {
                boosterWallet.setBalance(boosterWallet.getBalance().add(req.getBoosterIncome()));
                walletMapper.update(boosterWallet);
                // TODO: Add transaction log
            }
        }
        
        // 3. Penalty (Deduct from Booster if it means taking from existing funds? 
        // Usually penalty is just 'not giving income'. If it's extra penalty, we assume logic is handled in calculation)
        // For this implementation, we just record it. If we need to deduct from margin/deposit, we'd need that logic.
        // Assuming "Penalty" is just a record field for now or deducted from other earnings.

        // Log timeline
        timelineService.log(order.getId(), StpUtil.getLoginIdAsLong(), "管理员", "售后判决", "售后已判决，资金已分配", null);
    }

    @Transactional
    public void delete(Long id) {
        AfterSalesEntity entity = afterSalesMapper.selectById(id);
        if (entity == null) {
            throw new RuntimeException("售后单不存在");
        }

        // If status is PENDING, unlock the order
        if ("PENDING".equals(entity.getStatus())) {
            OrderEntity order = orderMapper.selectById(entity.getOrderId());
            if (order != null && "LOCKED".equals(order.getStatus())) {
                order.setStatus("PROCESSING"); // Revert to processing
                order.setUpdatedAt(LocalDateTime.now());
                orderMapper.update(order);
            }
        }

        afterSalesMapper.delete(id);
    }
}
