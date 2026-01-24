package com.tencent.tdesign.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class AfterSalesEntity {
    private Long id;
    private Long orderId;
    private Long initiatorId;
    private String reasonType; // GUARANTEE_STUCK, TIMEOUT, ATTITUDE, BAN, RECOVERY, LOSS
    private String description;
    private String evidenceImgs; // JSON array
    private String status; // PENDING, NEGOTIATING, RESOLVED, CLOSED
    private BigDecimal refundAmount;
    private BigDecimal boosterIncome;
    private BigDecimal penaltyAmount;
    private String adminRemark;
    private LocalDateTime resolvedAt;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    
    // Non-database fields
    private String boosterName;

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getOrderId() { return orderId; }
    public void setOrderId(Long orderId) { this.orderId = orderId; }
    public Long getInitiatorId() { return initiatorId; }
    public void setInitiatorId(Long initiatorId) { this.initiatorId = initiatorId; }
    public String getReasonType() { return reasonType; }
    public void setReasonType(String reasonType) { this.reasonType = reasonType; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getEvidenceImgs() { return evidenceImgs; }
    public void setEvidenceImgs(String evidenceImgs) { this.evidenceImgs = evidenceImgs; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public BigDecimal getRefundAmount() { return refundAmount; }
    public void setRefundAmount(BigDecimal refundAmount) { this.refundAmount = refundAmount; }
    public BigDecimal getBoosterIncome() { return boosterIncome; }
    public void setBoosterIncome(BigDecimal boosterIncome) { this.boosterIncome = boosterIncome; }
    public BigDecimal getPenaltyAmount() { return penaltyAmount; }
    public void setPenaltyAmount(BigDecimal penaltyAmount) { this.penaltyAmount = penaltyAmount; }
    public String getAdminRemark() { return adminRemark; }
    public void setAdminRemark(String adminRemark) { this.adminRemark = adminRemark; }
    public LocalDateTime getResolvedAt() { return resolvedAt; }
    public void setResolvedAt(LocalDateTime resolvedAt) { this.resolvedAt = resolvedAt; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public String getBoosterName() { return boosterName; }
    public void setBoosterName(String boosterName) { this.boosterName = boosterName; }
}
