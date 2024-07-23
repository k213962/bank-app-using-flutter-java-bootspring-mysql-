package org.example.Service;

import org.example.Dto.ApproveDepositDto;
import org.example.Dto.LoginDto;
import org.example.Dto.UserDto;
import org.example.Entity.PendingDeposits;
import org.example.Entity.User;
import org.example.Response.LoginMessage;

import java.util.List;

public interface AdminService {

    int approveDeposit(ApproveDepositDto approveDepositDto);

    int deleteUser(String UserId);

    int updateUser(UserDto userDto);

    List<User> getAllUser();
    User getSingleUser(String userId);

    LoginMessage loginAdmin(LoginDto loginDto);


    List<PendingDeposits> getAllPendingDeposits();
}
