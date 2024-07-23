package org.example.Entity;


import jakarta.persistence.*;
import org.hibernate.annotations.GenericGenerator;

import java.math.BigDecimal;
import java.util.List;


@Entity

@Table(name="user_account")

public class UserAccount {

    @Id
    @Column(name="account_no")
    private String accountNo;

    public UserAccount(){};
    public UserAccount(String accountNo, BigDecimal amount, User user) {
        this.accountNo = accountNo;
        this.amount = amount;
        this.user = user;
    }

    @Column(name="amount",nullable = false)
    private BigDecimal amount;

    public String getAccountNo() {
        return accountNo;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public User getUser() {
        return user;
    }

    @OneToMany(mappedBy = "requesterAccount",cascade = CascadeType.ALL)
   List<PendingDeposits> pendingDepositsList;
    @OneToOne
    @JoinColumn(referencedColumnName ="user_id",name="user_id",nullable = false)
    private User user;

}
