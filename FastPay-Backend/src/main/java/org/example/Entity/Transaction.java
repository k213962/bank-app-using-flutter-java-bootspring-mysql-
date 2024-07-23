package org.example.Entity;

import jakarta.persistence.*;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.boot.context.properties.bind.DefaultValue;

import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name="transaction")

public class Transaction {

    @Column(name="transaction_id",nullable = false,unique = true)
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE,generator = "transaction_seq_generator")
    @SequenceGenerator(name="transaction_seq_generator",sequenceName = "transaction_seq",allocationSize=1)

    private int Id;

    @ManyToOne
    @JoinColumn(referencedColumnName =  "user_id",name="sender")
    private User sender;


    @ManyToOne
    @JoinColumn(referencedColumnName ="user_id",name="receiver")
    private User receiver;



    @Column(name="status")
    private  boolean status;

    @Column(name="transaction_amount")
    private BigDecimal transactionAmount;

    public Transaction(int id, User sender, User receiver, boolean status, BigDecimal transactionAmount, Date transactionDate) {
        Id = id;
        this.sender = sender;
        this.receiver = receiver;
        this.status = status;
        this.transactionAmount = transactionAmount;
        this.transactionDate = transactionDate;
    }

    @Column(name="transaction_date")
    private Date transactionDate;

    public BigDecimal getTransactionAmount() {
        return transactionAmount;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public User getSender() {
        return sender;
    }

    public User getReceiver() {
        return receiver;
    }

    public Transaction(){};

    public int getId()
    {
        return Id;
    }
}
