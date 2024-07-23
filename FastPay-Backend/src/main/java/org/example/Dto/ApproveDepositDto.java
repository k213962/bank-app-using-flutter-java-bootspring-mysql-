package org.example.Dto;

import java.math.BigDecimal;

public class ApproveDepositDto {

    public int Id;

    public String getRequestedAccountNumber() {
        return requestedAccountNumber;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public int getId()
    {
        return Id;
    }
    private String requestedAccountNumber;
    private BigDecimal amount;

    private int pendingDepositId;

    public int getPendingDepositId() {
        return pendingDepositId;
    }

    public ApproveDepositDto(int id, int pendingDepositId, String requestedAccountNumber, BigDecimal amount) {
        Id = id;
        this.pendingDepositId=Id;
        this.requestedAccountNumber = requestedAccountNumber;
        this.amount = amount;
    }
}
