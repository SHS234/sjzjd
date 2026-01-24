package com.tencent.tdesign.dto;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;

public class OrderUpsertRequest {
    private String title;

    @NotNull(message = "订单金额不能为空")
    @DecimalMin(value = "0.01", message = "订单金额必须大于0")
    private BigDecimal amount;

    private String description;
    
    @NotBlank(message = "区服不能为空")
    private String region;
    
    @NotBlank(message = "游戏名称不能为空")
    private String gameName;
    
    private String gameMode;
    
    private String accountUsername;
    
    private String accountPassword;

    private String gameMetaData; // JSON string for extra requirements
    private String proofImages; // JSON string
    private String deadlineTime;
    private Boolean isPaused;
    private String pauseReason;

    private String customerName;
    private String customerPhone;
    private String customerWechat;
    private String customerQq;
    private String customerSource;
    private String xianyuOrderNo;
    private String gameUid;
    private String gameRank;
    private String banRecord;
    private String specialRequirements;

    // Getters and Setters
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public String getGameName() {
        return gameName;
    }

    public void setGameName(String gameName) {
        this.gameName = gameName;
    }

    public String getGameMode() {
        return gameMode;
    }

    public void setGameMode(String gameMode) {
        this.gameMode = gameMode;
    }

    public String getAccountUsername() {
        return accountUsername;
    }

    public void setAccountUsername(String accountUsername) {
        this.accountUsername = accountUsername;
    }

    public String getAccountPassword() {
        return accountPassword;
    }

    public void setAccountPassword(String accountPassword) {
        this.accountPassword = accountPassword;
    }

    public String getGameMetaData() {
        return gameMetaData;
    }
    
    public void setGameMetaData(String gameMetaData) {
        this.gameMetaData = gameMetaData;
    }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getCustomerPhone() { return customerPhone; }
    public void setCustomerPhone(String customerPhone) { this.customerPhone = customerPhone; }

    public String getCustomerWechat() { return customerWechat; }
    public void setCustomerWechat(String customerWechat) { this.customerWechat = customerWechat; }

    public String getCustomerQq() { return customerQq; }
    public void setCustomerQq(String customerQq) { this.customerQq = customerQq; }

    public String getCustomerSource() { return customerSource; }
    public void setCustomerSource(String customerSource) {
        this.customerSource = customerSource;
    }

    public String getXianyuOrderNo() {
        return xianyuOrderNo;
    }

    public void setXianyuOrderNo(String xianyuOrderNo) {
        this.xianyuOrderNo = xianyuOrderNo;
    }

    public String getGameUid() { return gameUid; }
    public void setGameUid(String gameUid) { this.gameUid = gameUid; }

    public String getGameRank() { return gameRank; }
    public void setGameRank(String gameRank) { this.gameRank = gameRank; }

    public String getBanRecord() { return banRecord; }
    public void setBanRecord(String banRecord) { this.banRecord = banRecord; }

    public String getSpecialRequirements() { return specialRequirements; }
    public void setSpecialRequirements(String specialRequirements) { this.specialRequirements = specialRequirements; }

    public String getProofImages() {
        return proofImages;
    }

    public void setProofImages(String proofImages) {
        this.proofImages = proofImages;
    }

    public String getDeadlineTime() {
        return deadlineTime;
    }

    public void setDeadlineTime(String deadlineTime) {
        this.deadlineTime = deadlineTime;
    }

    public Boolean getIsPaused() {
        return isPaused;
    }

    public void setIsPaused(Boolean isPaused) {
        this.isPaused = isPaused;
    }

    public String getPauseReason() {
        return pauseReason;
    }

    public void setPauseReason(String pauseReason) {
        this.pauseReason = pauseReason;
    }
}
