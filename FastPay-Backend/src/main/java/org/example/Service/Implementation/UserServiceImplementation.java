package org.example.Service.Implementation;

import org.example.Dto.DepositDto;
import org.example.Dto.LoginDto;
import org.example.Dto.TransactionDetailDto;
import org.example.Dto.UserDto;
import org.example.Entity.PendingDeposits;
import org.example.Entity.Transaction;
import org.example.Entity.User;
import org.example.Entity.UserAccount;
import org.example.Repository.PendingDepositRepository;
import org.example.Repository.TransactionRepository;
import org.example.Repository.UserAccountRepository;
import org.example.Repository.UserRepository;
import org.example.Response.LoginMessage;
import org.example.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Service
public class UserServiceImplementation implements UserService {

    private String generateAccountNumber(int userId) {
        return "ACCFastPay00" + userId;
    }

    @Autowired
    private UserRepository userRepository;


    @Autowired
    private TransactionRepository transactionRepository;
    @Autowired
    UserAccountRepository userAccountRepository;

    @Autowired
    PendingDepositRepository pendingDepositRepository;
    @Override
    public int addUser(UserDto userDto) {


        User user = new User(
                userDto.getUserId(),
                userDto.getUserName(),
                userDto.getGender(),

                userDto.getCNIC(),
                userDto.getEmail(),
                userDto.getPhoneNumber(),
                userDto.getPinCode()
        );
        if (user != null) {
            try {
                userRepository.save(user);

                UserAccount userAccount = new UserAccount(
                        generateAccountNumber(user.getUserId()), new BigDecimal("0"),
                        user
                );
                userAccountRepository.save(userAccount);


                return user.getUserId();
            } catch (Exception e) {
                System.out.println(e.getMessage());
                return -1;


            }
        } else
            return -1;
    }

    @Override
    public LoginMessage loginUser(LoginDto loginDTO) {
        String msg = "";
        String email = loginDTO.getEmail();
        User user = userRepository.findOneByEmailAndPinCode(loginDTO.getEmail(), loginDTO.getPinCode());
        System.out.println("user:" + user);
        if (user != null) {

            UserAccount userAccount = userAccountRepository.findByUser(user);
            ;
            if (userAccount != null)
                return new LoginMessage("Login Success", true, new UserAccount(userAccount.getAccountNo()

                        , userAccount.getAmount(),
                        userAccount.getUser()));
        } else {
            return new LoginMessage("Login Failed", false, null);

        }
        return new LoginMessage("Credentials are wrong", false, null);
    }

    @Override
    public int depositAmount(DepositDto depositDto) {

        try {
            PendingDeposits pendingDeposits = new PendingDeposits(
                    depositDto.getId(), userAccountRepository.findOneByAccountNo(depositDto.getRequestedAccountNumber()),

                    depositDto.getAmount());
            pendingDepositRepository.save(pendingDeposits);
            return pendingDeposits.getId();
        } catch (Exception e) {
            System.out.println("Error Message:" + e.getMessage());
            return -1;
        }


    }

    @Override
    public List<TransactionDetailDto> getAllTransaction(int userId) {
        System.out.println("userId:"+userId);
        List<TransactionDetailDto> allTransactionDetails=new ArrayList<>();

        try {
            User currentUser = userRepository.findOneByUserId(userId);
            System.out.println("Current User:"+currentUser);
            User user;
            List<Transaction> creditTransaction = transactionRepository.findAllByReceiver(currentUser);
            System.out.println("CreditTransaction:"+creditTransaction);
            List<Transaction> debitTransaction = transactionRepository.findAllBySender(currentUser);
            System.out.println("DebitTransaction:"+debitTransaction);
            if (creditTransaction.size() >= 1) {
                for (Transaction transaction : creditTransaction) {
                    user = transaction.getSender();

                    allTransactionDetails.add(
                            new TransactionDetailDto(
                                    user.getUserName(),
                                    currentUser.getUserName(),
                                    transaction.getTransactionDate(),
                                    transaction.getTransactionAmount()));

                }
            }
            if (debitTransaction.size() >= 1) {
                for (Transaction transaction : debitTransaction) {
                    user = transaction.getReceiver();

                    allTransactionDetails.add(
                            new TransactionDetailDto(
                                    currentUser.getUserName(),
                                    user.getUserName(),
                                    transaction.getTransactionDate(),
                                    transaction.getTransactionAmount()));

                }
            }
            return allTransactionDetails;


        } catch (Exception e) {
            System.out.println("Error Message:" + e.getMessage());
            return null;
        }

    }
}
