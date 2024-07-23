package org.example.Service.Implementation;

import jakarta.transaction.Transactional;
import org.example.Bean.Admin;
import org.example.Dto.ApproveDepositDto;
import org.example.Dto.LoginDto;
import org.example.Dto.UserDto;
import org.example.Entity.PendingDeposits;
import org.example.Entity.Transaction;
import org.example.Entity.User;
import org.example.Entity.UserAccount;
import org.example.Repository.*;
import org.example.Response.LoginMessage;
import org.example.Service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class AdminServiceImplementation implements AdminService {


   @Autowired
    Admin admin;
    @Autowired
    TransactionRepository transactionRepository;

    @Autowired
    UserRepository userRepository;

    @Autowired
    UserAccountRepository userAccountRepository;


    @Autowired
    PendingDepositRepository pendingDepositRepository;

    @Override
    public int approveDeposit(ApproveDepositDto approveDepositDto)
    {
        try {
            UserAccount requesterAccount = userAccountRepository.findOneByAccountNo(approveDepositDto.getRequestedAccountNumber());
            UserAccount adminAccount = admin.getAdminUserAccount();
            User requester = requesterAccount.getUser();
            User adminUser=admin.getAdminUser();
           //update
            userAccountRepository.save(
                    new UserAccount(
                            adminAccount.getAccountNo(),
                            adminAccount.getAmount().subtract(approveDepositDto.getAmount()),
                            adminUser));
            //update
            userAccountRepository.save(
                    new UserAccount(
                            requesterAccount.getAccountNo(),
                            requesterAccount.getAmount().add(approveDepositDto.getAmount()),
                            requester));
            //insert
            Transaction transaction =new Transaction(
                    approveDepositDto.getId(),
                    adminUser,requester,
                    true,
                    approveDepositDto.getAmount(),
                    new Date());
            transactionRepository.save(transaction);
            pendingDepositRepository.deleteById(approveDepositDto.getPendingDepositId());
               return  transaction.getId();

        }
        catch(Exception e)
        {
           System.out.println("Error Message:"+e.getMessage());
           return -1;
        }
    }

    @Override
    public LoginMessage loginAdmin(LoginDto loginDTO) {
        String msg = "";
        String email = loginDTO.getEmail();
        User adminUser=admin.getAdminUser();
        User user = userRepository.findOneByEmailAndPinCode(loginDTO.getEmail(), loginDTO.getPinCode());
        System.out.println("user:" + user);
        if (user != null) {

            UserAccount userAccount = userAccountRepository.findByUser(user);
            if (userAccount != null && user.equals(adminUser))
                return new LoginMessage("Login Success", true, new UserAccount(userAccount.getAccountNo()

                        , userAccount.getAmount(),
                        userAccount.getUser()));
        } else {
            return new LoginMessage("Login Failed", false, null);

        }
        return new LoginMessage("Credentials are wrong", false, null);
    }

    @Override
    public int updateUser(UserDto userDto)
    {
        User existingUser;
        try{
           System.out.println("USERDTO:"+userDto.getUserId());
            existingUser=userRepository.findOneByUserId(userDto.getUserId());
            System.out.println("existingUser:"+existingUser);
            if(existingUser!=null)
            {
                User updatedUser=new User(
                        userDto.getUserId(),
                        userDto.getUserName(),
                        userDto.getGender(),
                        userDto.getCNIC(),
                        userDto.getEmail(),
                        userDto.getPhoneNumber(),
                        userDto.getPinCode()
                );
                userRepository.save(updatedUser);
                return updatedUser.getUserId();

            }
            else{
            return -1;
        }}
        catch(Exception e)
        {
            System.out.println("Error Message:"+e.getMessage());
            return -1;
        }
    }
    @Override
    @Transactional
    public int deleteUser(String userId)
    {
        try
        {
            userRepository.deleteById(Integer.parseInt(userId));
            return 1;
        }
        catch(Exception e)
        {
            System.out.println("Error Message:"+e.getMessage());
            return -1;
        }
    }
    @Override
    public User getSingleUser(String userId)
    {
        try
        {
            return userRepository.findOneByUserId(Integer.parseInt(userId));
        }
        catch(Exception e)
        {
            System.out.println("Error Message:"+e.getMessage());
            return null;
        }
    }

    public List<User> getAllUser()
    {
           try{
              return  userRepository.findAll();
           }
           catch(Exception e){
               System.out.println("Error Message:"+e.getMessage());
               return null;
           }
    }

    public List<PendingDeposits> getAllPendingDeposits()
    {
        try{
            return pendingDepositRepository.findAll();
        }
        catch(Exception e)
        {
            System.out.println("Error Message:"+e.getMessage());
            return null;
        }
    }

}
