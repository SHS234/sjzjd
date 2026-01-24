package com.tencent.tdesign.service;

import com.tencent.tdesign.entity.*;
import com.tencent.tdesign.mapper.SettlementMapper;
import com.tencent.tdesign.mapper.TransactionMapper;
import com.tencent.tdesign.mapper.WalletMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
public class FinanceService {

    @Autowired
    private WalletMapper walletMapper;

    @Autowired
    private SettlementMapper settlementMapper;

    @Autowired
    private TransactionMapper transactionMapper;

    /**
     * Get or create wallet for booster
     */
    public WalletEntity getWallet(Long boosterId) {
        WalletEntity wallet = walletMapper.selectByBoosterId(boosterId);
        if (wallet == null) {
            wallet = new WalletEntity();
            wallet.setBoosterId(boosterId);
            wallet.setBalance(BigDecimal.ZERO);
            wallet.setFrozenBalance(BigDecimal.ZERO);
            wallet.setDeposit(BigDecimal.ZERO);
            wallet.setTotalWithdrawn(BigDecimal.ZERO);
            wallet.setCreatedAt(LocalDateTime.now());
            wallet.setUpdatedAt(LocalDateTime.now());
            walletMapper.insert(wallet);
        }
        return wallet;
    }

    /**
     * Create settlement record when order is completed
     */
    @Transactional
    public void createSettlement(OrderEntity order) {
        if (order.getBoosterId() == null) {
            return;
        }

        SettlementEntity settlement = new SettlementEntity();
        settlement.setOrderNo(order.getOrderNo());
        settlement.setBoosterId(order.getBoosterId());
        settlement.setTotalAmount(order.getAmount());
        
        // 80% to booster
        BigDecimal ratio = new BigDecimal("0.80");
        BigDecimal boosterAmount = order.getAmount().multiply(ratio);
        BigDecimal platformAmount = order.getAmount().subtract(boosterAmount);
        
        settlement.setBoosterAmount(boosterAmount);
        settlement.setPlatformAmount(platformAmount);
        settlement.setRatio(ratio);
        settlement.setStatus("PENDING");
        // Settle after 7 days
        settlement.setSettleTime(LocalDateTime.now().plusDays(7));
        settlement.setCreatedAt(LocalDateTime.now());
        settlement.setUpdatedAt(LocalDateTime.now());
        
        settlementMapper.insert(settlement);
        
        // Update wallet frozen balance
        WalletEntity wallet = getWallet(order.getBoosterId());
        wallet.setFrozenBalance(wallet.getFrozenBalance().add(boosterAmount));
        walletMapper.update(wallet);
    }

    /**
     * Process pending settlements (Scheduled task)
     * This method should be called by a scheduler
     */
    @Transactional
    public void processSettlements() {
        // In a real scenario, we would select settlements due for payment
        // For now, let's just provide a method to settle a specific settlement
    }

    /**
     * Manually settle a record (or triggered by scheduler)
     */
    @Transactional
    public void settle(Long settlementId) {
        SettlementEntity settlement = settlementMapper.selectById(settlementId);
        if (settlement == null || !"PENDING".equals(settlement.getStatus())) {
            return;
        }
        
        // Update settlement status
        settlement.setStatus("SETTLED");
        settlement.setUpdatedAt(LocalDateTime.now());
        settlementMapper.update(settlement);
        
        // Update wallet
        WalletEntity wallet = getWallet(settlement.getBoosterId());
        BigDecimal amount = settlement.getBoosterAmount();
        
        wallet.setFrozenBalance(wallet.getFrozenBalance().subtract(amount));
        wallet.setBalance(wallet.getBalance().add(amount));
        walletMapper.update(wallet);
        
        // Record transaction
        recordTransaction(
            settlement.getBoosterId(), 
            "INCOME", 
            amount, 
            wallet.getBalance(), 
            settlement.getOrderNo(), 
            "订单结算入账"
        );
    }
    
    /**
     * Record a transaction
     */
    private void recordTransaction(Long boosterId, String type, BigDecimal amount, BigDecimal balanceAfter, String relatedId, String note) {
        TransactionEntity tx = new TransactionEntity();
        tx.setTransactionNo(UUID.randomUUID().toString());
        tx.setBoosterId(boosterId);
        tx.setType(type);
        tx.setAmount(amount);
        tx.setBalanceAfter(balanceAfter);
        tx.setRelatedId(relatedId);
        tx.setNote(note);
        tx.setCreatedAt(LocalDateTime.now());
        transactionMapper.insert(tx);
    }

    public List<SettlementEntity> getSettlements(int page, int size, Long boosterId, String status) {
        return settlementMapper.selectPage(size, (page - 1) * size, boosterId, status);
    }

    public long countSettlements(Long boosterId, String status) {
        return settlementMapper.count(boosterId, status);
    }
    
    public List<TransactionEntity> getTransactions(int page, int size, Long boosterId, String type) {
        return transactionMapper.selectPage(size, (page - 1) * size, boosterId, type);
    }

    public long countTransactions(Long boosterId, String type) {
        return transactionMapper.count(boosterId, type);
    }
}
