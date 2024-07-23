package org.example.Dto;

import org.example.Entity.User;

import java.math.BigDecimal;

public class TransactionDto {


    private String senderAccountNumber;
    private String receiverAccountNumber;
    private int Id;
    private BigDecimal amount;


    public TransactionDto( int id,String senderAccountNumber, String receiverAccountNumber, BigDecimal amount) {
        this.senderAccountNumber = senderAccountNumber;
        this.receiverAccountNumber = receiverAccountNumber;
        Id = id;
        this.amount = amount;

    }

    public String getSenderAccountNumber() {
        return senderAccountNumber;
    }

    public String getReceiverAccountNumber() {
        return receiverAccountNumber;
    }

    public int getId() {
        return Id;
    }

    public BigDecimal getAmount() {
        return amount;
    }


}
