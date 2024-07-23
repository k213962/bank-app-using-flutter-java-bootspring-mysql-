package org.example.Dto;

import java.math.BigDecimal;

public class DepositDto {


    int Id;
    private BigDecimal amount;

    public int getId() {
        return Id;
    }

    private String requestedAccountNumber;

    public DepositDto(int Id, BigDecimal amount, String requestedAccountNumber) {
        this.Id = Id;
        this.amount = amount;
        this.requestedAccountNumber = requestedAccountNumber;
    }



    public BigDecimal getAmount() {
        return amount;
    }

    public String getRequestedAccountNumber() {
        return requestedAccountNumber;
    }
}
