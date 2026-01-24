package com.tencent.tdesign.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class WalletEntity {
    private Long boosterId;
    private BigDecimal balance;
    private BigDecimal frozenBalance;
    private BigDecimal deposit;
    private BigDecimal totalWithdrawn;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Long getBoosterId() {
        return boosterId;
    }

    public void setBoosterId(Long boosterId) {
        this.boosterId = boosterId;
    }

    public BigDecimal getBalance() {
        return balance;
    }

    public void setBalance(BigDecimal balance) {
        this.balance = balance;
    }

    public BigDecimal getFrozenBalance() {
        return frozenBalance;
    }

    public void setFrozenBalance(BigDecimal frozenBalance) {
        this.frozenBalance = frozenBalance;
    }

    public BigDecimal getDeposit() {
        return deposit;
    }

    public void setDeposit(BigDecimal deposit) {
        this.deposit = deposit;
    }

    public BigDecimal getTotalWithdrawn() {
        return totalWithdrawn;
    }

    public void setTotalWithdrawn(BigDecimal totalWithdrawn) {
        this.totalWithdrawn = totalWithdrawn;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
}
