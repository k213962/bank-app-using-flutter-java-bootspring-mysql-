package org.example.Service;

import org.example.Dto.DepositDto;
import org.example.Dto.LoginDto;
import org.example.Dto.TransactionDetailDto;
import org.example.Dto.UserDto;
import org.example.Entity.User;
import org.example.Response.LoginMessage;

import java.util.List;

public interface UserService {
    int addUser(UserDto userDto);
    LoginMessage loginUser(LoginDto loginDto);

    int depositAmount(DepositDto depositDto);

    List<TransactionDetailDto> getAllTransaction(int userId);


}
