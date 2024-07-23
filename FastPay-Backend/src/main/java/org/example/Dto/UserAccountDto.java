package org.example.Dto;

import org.example.Entity.User;

import java.math.BigDecimal;

public class UserAccountDto {

    private String accountNo;
    private User user;

    public String getAccountNo() {
        return accountNo;
    }

    public User getUser() {
        return user;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public UserAccountDto(String accountNo, User user, BigDecimal amount) {
        this.accountNo = accountNo;
        this.user = user;
        this.amount = amount;
    }


    private BigDecimal amount;


}
