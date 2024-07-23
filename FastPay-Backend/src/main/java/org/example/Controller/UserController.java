package org.example.Controller;

import jakarta.validation.Valid;
import org.example.Dto.*;
import org.example.Response.LoginMessage;
import org.example.Service.TransactionService;
import org.example.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin()
@RequestMapping("api/v1/user")
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private TransactionService transactionService;

    @PostMapping("/")
    public String status()
    {
        return "status: ok";
    }
    @PostMapping("/save")
    public int createUser(@Valid @RequestBody UserDto userDto)
    {
        int id=userService.addUser(userDto);
        return id;
    }
    @PostMapping("/login")
    public LoginMessage loginUser(@Valid @RequestBody LoginDto loginDto)
    {
        LoginMessage loginMessage =userService.loginUser(loginDto);
        return loginMessage;
    }

    @PostMapping("/sendAmount")
    public int sendAmount(@Valid @RequestBody TransactionDto transactionDto)
    {
        int id=transactionService.sendAmount(transactionDto);
        return id;
    }
    @RequestMapping(value="transaction/{id}", method = RequestMethod.GET)
    public @ResponseBody
    List<TransactionDetailDto> getAllTransaction(@PathVariable("id")  String userId)

    {

          return userService.getAllTransaction(Integer.parseInt(userId));
    }
    @PostMapping("/depositAmount")
    public int depositAmount(@RequestBody  DepositDto depositDto)
    {
        return userService.depositAmount(depositDto);
    }

}
