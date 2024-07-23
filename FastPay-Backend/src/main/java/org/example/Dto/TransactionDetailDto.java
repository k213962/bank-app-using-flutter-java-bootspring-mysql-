package org.example.Dto;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.math.BigDecimal;
import java.util.Date;

public class TransactionDetailDto {


    @JsonProperty("senderUserName")
    private String senderUserName;
    @JsonProperty("receiverUserName")
    private String receiverUserName;
    @JsonProperty("transactionDate")

    private Date transactionDate;

    @JsonProperty("transactionAmount")
     private BigDecimal transactionAmount;

    public TransactionDetailDto(String senderUserName, String receiverUserName, Date transactionDate, BigDecimal transactionAmount) {
        this.senderUserName = senderUserName;
        this.receiverUserName = receiverUserName;
        this.transactionDate = transactionDate;
        this.transactionAmount = transactionAmount;
    }
}
