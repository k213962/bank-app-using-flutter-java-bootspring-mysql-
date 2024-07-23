package org.example.Bean;

import org.example.Entity.User;
import org.example.Entity.UserAccount;
import org.example.Repository.UserAccountRepository;
import org.example.Repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


@Component
public class Admin {

    private int userId = 1;
    private String accountNumber = "ACCFastPay001";
    @Autowired
    UserRepository userRepository;
    @Autowired
    UserAccountRepository userAccountRepository;

    public User getAdminUser() {
        return userRepository.findOneByUserId(userId);
    }

    public UserAccount getAdminUserAccount() {
        return userAccountRepository.findOneByAccountNo(accountNumber);
    }


}



