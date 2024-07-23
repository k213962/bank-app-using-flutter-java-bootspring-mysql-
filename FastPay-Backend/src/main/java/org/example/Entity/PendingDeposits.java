package org.example.Entity;


import jakarta.persistence.*;

import java.math.BigDecimal;

@Entity
@Table(name="pending_deposits")
public class PendingDeposits {

    @Column(name = "pending_deposit_id", length = 1)
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "deposit_id")
    @SequenceGenerator(name="deposit_id", sequenceName = "pending_deposit_id_seq", allocationSize=1)
    private int Id;

    public UserAccount getRequesterAccount() {
        return requesterAccount;
    }

    public BigDecimal getAmount() {
        return Amount;
    }

    public PendingDeposits(int id, UserAccount requesterAccount, BigDecimal amount) {
        Id = id;
        this.requesterAccount = requesterAccount;
        Amount = amount;
    }
    public PendingDeposits(){};
    public int getId() {
        return Id;
    }


    @ManyToOne
    @JoinColumn(referencedColumnName ="account_no",name="requester")
    private UserAccount requesterAccount;

    @Column(name="amount")
    BigDecimal Amount;

}
