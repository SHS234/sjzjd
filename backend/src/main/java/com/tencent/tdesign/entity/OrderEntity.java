package com.tencent.tdesign.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class OrderEntity {
  private Long id;
  private String orderNo;
  private String title;
  private Long customerId;
  private Long boosterId;
  private BigDecimal amount;
  private String status; // PENDING, PROCESSING, COMPLETED, CANCELLED, LOCKED
  private String description;
  private String region;
  private String gameName;
  private String gameMode;
  private String accountUsername;
  private String accountPassword;
  private String gameMetaData; // JSON string
  private String proofImages; // JSON string
  private LocalDateTime deadlineTime;
  private Boolean isPaused;
  private String pauseReason;
  private LocalDateTime createdAt;
  private LocalDateTime updatedAt;

  private String customerName;
  private String customerPhone;
  private String customerWechat;
  private String customerQq;
  private String xianyuOrderNo;
  private String gameUid;
    private String gameRank;
    private String banRecord;
    private String specialRequirements;

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getOrderNo() {
    return orderNo;
  }

  public void setOrderNo(String orderNo) {
    this.orderNo = orderNo;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public Long getCustomerId() {
    return customerId;
  }

  public void setCustomerId(Long customerId) {
    this.customerId = customerId;
  }

  public Long getBoosterId() {
    return boosterId;
  }

  public void setBoosterId(Long boosterId) {
    this.boosterId = boosterId;
  }

  public BigDecimal getAmount() {
    return amount;
  }

  public void setAmount(BigDecimal amount) {
    this.amount = amount;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
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

  public String getCustomerName() { return customerName; }
  public void setCustomerName(String customerName) { this.customerName = customerName; }

  public String getCustomerPhone() { return customerPhone; }
  public void setCustomerPhone(String customerPhone) { this.customerPhone = customerPhone; }

  public String getCustomerWechat() { return customerWechat; }
  public void setCustomerWechat(String customerWechat) { this.customerWechat = customerWechat; }

  public String getCustomerQq() { return customerQq; }
  public void setCustomerQq(String customerQq) { this.customerQq = customerQq; }

  public String getXianyuOrderNo() {
    return xianyuOrderNo;
  }

  public void setXianyuOrderNo(String xianyuOrderNo) {
    this.xianyuOrderNo = xianyuOrderNo;
  }

  public String getGameUid() { return gameUid; }
  public void setGameUid(String gameUid) { this.gameUid = gameUid; }

  public String getGameRank() { return gameRank; }
  public void setGameRank(String gameRank) {
    this.gameRank = gameRank;
  }

  public String getBanRecord() {
    return banRecord;
  }

  public void setBanRecord(String banRecord) {
    this.banRecord = banRecord;
  }

  public String getSpecialRequirements() {
    return specialRequirements;
  }
  public void setSpecialRequirements(String specialRequirements) { this.specialRequirements = specialRequirements; }

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

  public String getProofImages() {
    return proofImages;
  }

  public void setProofImages(String proofImages) {
    this.proofImages = proofImages;
  }

  public LocalDateTime getDeadlineTime() {
    return deadlineTime;
  }

  public void setDeadlineTime(LocalDateTime deadlineTime) {
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
