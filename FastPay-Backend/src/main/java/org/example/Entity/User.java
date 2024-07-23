package org.example.Entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Size;
import org.example.Validations.Annotations.CNICValidator;
import org.hibernate.dialect.MySQL8Dialect;

import java.util.List;


@Entity
@Table(name="user")
public class User {

    @Id
    @Column(name = "user_id", length = 1)

    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "user_id")
    @SequenceGenerator(name="user_id", sequenceName = "user_id_seq", allocationSize=1)
    private int userId;
    @Column(name = "user_name", length = 255,nullable = false)
    private String userName;
    @Column(name = "email", length = 255,nullable = false,unique = true)
    @Email
    private String email;
    @Column(name = "phone_number", length = 11,nullable = false,unique = true)
    private String phoneNumber;

    @Column(name = "pin_code",nullable = false)

    private String pinCode;
    @Column(name = "gender", length = 1,nullable = false)
    private char gender;
    @Column(name = "CNIC", nullable = false,unique = true)
    @CNICValidator
    private String CNIC;

    @OneToOne(mappedBy = "user",cascade =CascadeType.ALL)
    private UserAccount userAccount;
    public String getUserName() {
        return userName;
    }

    @OneToMany(mappedBy="receiver",cascade = CascadeType.ALL)
    private List<Transaction> creditTransaction;

    @OneToMany(mappedBy="sender",cascade = CascadeType.ALL)

    private List<Transaction> debitTransaction;

    public User() {
    }

    public int getUserId() {
        return userId;
    }
    public String getPinCode()
    {
        return this.pinCode;
    }

    public User(int userId, String userName,char gender,String CNIC,String email, String phoneNumber, String pinCode) {

        this.userId = userId;
        this.userName = userName;
        this.email = email;
        this.pinCode = pinCode;
        this.CNIC = CNIC;
        this.phoneNumber=phoneNumber;
        this.gender = gender;


    }


    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
}
//create getters and setters
