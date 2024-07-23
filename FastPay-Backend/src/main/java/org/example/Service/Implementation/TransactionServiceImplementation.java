package org.example.Service.Implementation;

import org.example.Dto.DepositDto;
import org.example.Dto.TransactionDto;
import org.example.Entity.Transaction;
import org.example.Entity.User;
import org.example.Entity.UserAccount;
import org.example.Repository.TransactionRepository;
import org.example.Repository.UserAccountRepository;
import org.example.Repository.UserRepository;
import org.example.Service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.reflect.Type;
import java.math.BigDecimal;
import java.util.Date;

@Service

public class TransactionServiceImplementation implements TransactionService {
    @Autowired
    TransactionRepository transactionRepository;
    @Autowired
    UserAccountRepository userAccountRepository;
    @Autowired
    UserRepository userRepository;

    @Override
    public int sendAmount(TransactionDto transactionDto) {


        UserAccount senderAccount = userAccountRepository.findOneByAccountNo(transactionDto.getSenderAccountNumber());
        UserAccount receiverAccount = userAccountRepository.findOneByAccountNo(transactionDto.getReceiverAccountNumber());
        User sender;
        User receiver;
        if (senderAccount == null || senderAccount.getAmount().compareTo(transactionDto.getAmount()) < 0) {
            return -1;
        } else {
            sender = userRepository.findOneByUserId(senderAccount.getUser().getUserId());

        }
        if (receiverAccount == null) {
            return -1;
        } else {
            receiver = userRepository.findOneByUserId(receiverAccount.getUser().getUserId());
            System.out.println("receiver:" + receiver);
            try {
                userAccountRepository.save(new
                        UserAccount(receiverAccount.getAccountNo(),
                        receiverAccount.getAmount().add(transactionDto.getAmount()),
                        receiverAccount.getUser()));
                userAccountRepository.save(new
                        UserAccount(senderAccount.getAccountNo(),
                        senderAccount.getAmount().subtract(transactionDto.getAmount()),
                        senderAccount.getUser()));


                Transaction transaction = new
                        Transaction(transactionDto.getId(),
                        sender, receiver, true, transactionDto.getAmount(), new Date());
                transactionRepository.save(transaction);

                return transactionDto.getId();
            } catch (Exception e) {
                System.out.println("Error Message:" + e.getMessage());
                return -1;
            }


        }


    }
}
