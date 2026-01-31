package com.tencent.tdesign.service;

import cn.dev33.satoken.stp.StpUtil;
import com.tencent.tdesign.dto.OrderUpsertRequest;
import com.tencent.tdesign.entity.OrderEntity;
import com.tencent.tdesign.entity.BoosterEntity;
import com.tencent.tdesign.mapper.OrderMapper;
import com.tencent.tdesign.mapper.BoosterMapper;
import com.tencent.tdesign.vo.PageResult;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class OrderService {

    private final OrderMapper mapper;
    private final BoosterMapper boosterMapper;
    private final OrderTimelineService timelineService;
    private final FinanceService financeService;
    private final ObjectMapper objectMapper;

    public OrderService(OrderMapper mapper, BoosterMapper boosterMapper, OrderTimelineService timelineService, FinanceService financeService, ObjectMapper objectMapper) {
        this.mapper = mapper;
        this.boosterMapper = boosterMapper;
        this.timelineService = timelineService;
        this.financeService = financeService;
        this.objectMapper = objectMapper;
    }

    public PageResult<OrderEntity> page(String keyword, String status, int page, int size) {
        int offset = (page - 1) * size;
        if (offset < 0) {
            offset = 0;
        }
        List<OrderEntity> list = mapper.selectPage(keyword, status, offset, size);
        long total = mapper.count(keyword, status);
        return new PageResult<>(list, total);
    }

    public java.math.BigDecimal sumAmountByStatus(String status) {
        java.math.BigDecimal total = mapper.sumAmountByStatus(status);
        return total == null ? java.math.BigDecimal.ZERO : total;
    }

    public OrderEntity detail(Long id) {
        return mapper.selectById(id);
    }

    public OrderEntity getByOrderNo(String orderNo) {
        return mapper.selectByOrderNo(orderNo);
    }

    @Transactional
    public OrderEntity create(OrderUpsertRequest req) {
        OrderEntity entity = new OrderEntity();
        entity.setOrderNo(generateOrderNo());
        if (req.getTitle() == null || req.getTitle().trim().isEmpty()) {
            entity.setTitle("订单 " + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")));
        } else {
            entity.setTitle(req.getTitle());
        }
        entity.setAmount(req.getAmount());
        entity.setDescription(req.getDescription());
        entity.setRegion(req.getRegion());
        entity.setGameName(req.getGameName());
        entity.setGameMode(req.getGameMode());
        entity.setAccountUsername(req.getAccountUsername());
        entity.setAccountPassword(req.getAccountPassword());
        entity.setGameMetaData(req.getGameMetaData());
        entity.setProofImages(req.getProofImages());
        if (req.getDeadlineTime() != null) {
            String deadlineTime = req.getDeadlineTime().trim();
            if (deadlineTime.isEmpty()) {
                entity.setDeadlineTime(null);
            } else {
                entity.setDeadlineTime(LocalDateTime.parse(deadlineTime, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            }
        }
        entity.setIsPaused(req.getIsPaused());
        entity.setPauseReason(req.getPauseReason());

        entity.setCustomerName(req.getCustomerName());
        entity.setCustomerPhone(req.getCustomerPhone());
        entity.setCustomerWechat(req.getCustomerWechat());
        entity.setCustomerQq(req.getCustomerQq());
        entity.setXianyuOrderNo(req.getXianyuOrderNo());
        entity.setGameUid(req.getGameUid());
        entity.setGameRank(req.getGameRank());
        entity.setBanRecord(req.getBanRecord());
        entity.setSpecialRequirements(req.getSpecialRequirements());
        
        // Default values
        entity.setStatus("PENDING"); // 待接单
        entity.setIsPaused(false);
        if (StpUtil.isLogin()) {
             entity.setCustomerId(StpUtil.getLoginIdAsLong());
        }

        entity.setCreatedAt(LocalDateTime.now());
        entity.setUpdatedAt(LocalDateTime.now());

        mapper.insert(entity);
        
        // Log timeline
        timelineService.log(entity.getId(), entity.getCustomerId(), "系统", "订单创建", "客户已下单，等待接单", null);
        
        return entity;
    }
    
    @Transactional
    public OrderEntity update(Long id, OrderUpsertRequest req) {
        OrderEntity entity = mapper.selectById(id);
        if (entity == null) {
            throw new RuntimeException("订单不存在");
        }
        
        entity.setTitle(req.getTitle());
        entity.setAmount(req.getAmount());
        entity.setDescription(req.getDescription());
        entity.setRegion(req.getRegion());
        entity.setGameName(req.getGameName());
        entity.setGameMode(req.getGameMode());
        entity.setAccountUsername(req.getAccountUsername());
        entity.setAccountPassword(req.getAccountPassword());
        entity.setGameMetaData(req.getGameMetaData());
        entity.setProofImages(req.getProofImages());

        entity.setCustomerName(req.getCustomerName());
        entity.setCustomerPhone(req.getCustomerPhone());
        entity.setCustomerWechat(req.getCustomerWechat());
        entity.setCustomerQq(req.getCustomerQq());
        entity.setXianyuOrderNo(req.getXianyuOrderNo());
        entity.setGameUid(req.getGameUid());
        entity.setGameRank(req.getGameRank());
        entity.setBanRecord(req.getBanRecord());
        entity.setSpecialRequirements(req.getSpecialRequirements());
        
        mapper.update(entity);
        return entity;
    }

    @Transactional
    public void assign(Long orderId, Long boosterId) {
        OrderEntity order = mapper.selectById(orderId);
        if (order == null) {
            throw new RuntimeException("订单不存在");
        }
        
        boolean isChange = false;
        // If there is an existing booster, release them
        if (order.getBoosterId() != null) {
            isChange = true;
            BoosterEntity oldBooster = boosterMapper.selectById(order.getBoosterId());
            if (oldBooster != null) {
                oldBooster.setStatus("Online"); // Set back to Idle/Online
                oldBooster.setUpdatedAt(LocalDateTime.now());
                boosterMapper.update(oldBooster);
            }
        }
        
        BoosterEntity booster = boosterMapper.selectById(boosterId);
        if (booster == null) {
            throw new RuntimeException("打手不存在");
        }
        
        // Update Order
        order.setBoosterId(boosterId);
        order.setStatus("PROCESSING");
        order.setUpdatedAt(LocalDateTime.now());
        mapper.update(order);
        
        // Update Booster Status
        booster.setStatus("Busy");
        booster.setUpdatedAt(LocalDateTime.now());
        boosterMapper.update(booster);
        
        // Log timeline
        Long operatorId = StpUtil.isLogin() ? StpUtil.getLoginIdAsLong() : null;
        String action = isChange ? "更换打手" : "分配打手";
        String boosterInfo = booster.getName();
        if (booster.getNickname() != null && !booster.getNickname().isEmpty()) {
            boosterInfo += " (" + booster.getNickname() + ")";
        }
        String content = isChange ? "新打手：" + boosterInfo : "已分配给打手: " + boosterInfo;
        
        String metaJson = null;
        try {
            Map<String, Object> meta = new HashMap<>();
            meta.put("boosterId", booster.getId());
            meta.put("name", booster.getName());
            meta.put("nickname", booster.getNickname());
            metaJson = objectMapper.writeValueAsString(meta);
        } catch (Exception e) {
            e.printStackTrace();
        }

        timelineService.log(orderId, operatorId, "系统/管理员", action, content, metaJson);
    }

    @Transactional
    public void delete(Long id) {
        mapper.deleteById(id);
    }

    @Transactional
    public void complete(Long id) {
        OrderEntity entity = mapper.selectById(id);
        if (entity == null) {
            throw new RuntimeException("订单不存在");
        }
        if ("COMPLETED".equals(entity.getStatus())) {
            return;
        }

        entity.setStatus("COMPLETED");
        entity.setUpdatedAt(LocalDateTime.now());
        mapper.update(entity);

        // Update booster status to Online (Idle)
        // User request: Force update to Online regardless of other orders (or maybe assuming single order workflow)
        if (entity.getBoosterId() != null) {
            // long processingCount = mapper.countByBoosterIdAndStatus(entity.getBoosterId(), "PROCESSING");
            // if (processingCount == 0) {
                BoosterEntity booster = boosterMapper.selectById(entity.getBoosterId());
                if (booster != null) {
                    booster.setStatus("Online");
                    booster.setUpdatedAt(LocalDateTime.now());
                    boosterMapper.update(booster);
                }
            // }
        }
        
        // Create settlement
        financeService.createSettlement(entity);
        
        // Log timeline
        Long operatorId = StpUtil.isLogin() ? StpUtil.getLoginIdAsLong() : null;
        timelineService.log(id, operatorId, "系统/管理员", "订单完成", "订单已完成，系统自动生成结算", null);
    }

    private String generateOrderNo() {
        // Simple order no generation: ORD + Timestamp + Random
        return "ORD" + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")) + 
               String.format("%03d", (int)(Math.random() * 1000));
    }
}
