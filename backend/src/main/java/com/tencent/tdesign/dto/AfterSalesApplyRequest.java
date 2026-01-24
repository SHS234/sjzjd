package com.tencent.tdesign.dto;

import java.util.List;

public class AfterSalesApplyRequest {
    private Long orderId;
    private String reasonType;
    private String description;
    private List<String> evidenceImgs;

    public Long getOrderId() { return orderId; }
    public void setOrderId(Long orderId) { this.orderId = orderId; }
    public String getReasonType() { return reasonType; }
    public void setReasonType(String reasonType) { this.reasonType = reasonType; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public List<String> getEvidenceImgs() { return evidenceImgs; }
    public void setEvidenceImgs(List<String> evidenceImgs) { this.evidenceImgs = evidenceImgs; }
}
