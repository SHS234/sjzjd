package com.tencent.tdesign.dto;

import java.math.BigDecimal;

public class AfterSalesResolveRequest {
    private Long afterSalesId;
    private BigDecimal refundAmount;
    private BigDecimal boosterIncome;
    private BigDecimal penaltyAmount;
    private String adminRemark;

    public Long getAfterSalesId() { return afterSalesId; }
    public void setAfterSalesId(Long afterSalesId) { this.afterSalesId = afterSalesId; }
    public BigDecimal getRefundAmount() { return refundAmount; }
    public void setRefundAmount(BigDecimal refundAmount) { this.refundAmount = refundAmount; }
    public BigDecimal getBoosterIncome() { return boosterIncome; }
    public void setBoosterIncome(BigDecimal boosterIncome) { this.boosterIncome = boosterIncome; }
    public BigDecimal getPenaltyAmount() { return penaltyAmount; }
    public void setPenaltyAmount(BigDecimal penaltyAmount) { this.penaltyAmount = penaltyAmount; }
    public String getAdminRemark() { return adminRemark; }
    public void setAdminRemark(String adminRemark) { this.adminRemark = adminRemark; }
}
