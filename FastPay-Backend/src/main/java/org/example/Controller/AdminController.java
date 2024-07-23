package org.example.Controller;

import jakarta.validation.Valid;
import org.example.Dto.ApproveDepositDto;
import org.example.Dto.LoginDto;
import org.example.Dto.UserDto;
import org.example.Entity.PendingDeposits;
import org.example.Entity.User;
import org.example.Response.LoginMessage;
import org.example.Service.AdminService;
import org.example.Service.TransactionService;
import org.example.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.ListResourceBundle;

@RestController
@CrossOrigin
@RequestMapping("api/v1/admin")
public class AdminController {
    @Autowired
    AdminService adminService;

    @PostMapping("/login")
    public LoginMessage loginAdmin(@Valid @RequestBody LoginDto loginDto)
    {
        LoginMessage loginMessage =adminService.loginAdmin(loginDto);
        return loginMessage;
    }

    @GetMapping("/user")
    List<User> getAllUsers() {
        return adminService.getAllUser();
    }

    @RequestMapping(value="/user/{id}", method = RequestMethod.GET)
    public @ResponseBody
    User getSingleUsers(@PathVariable("id")  String userId) {
        return adminService.getSingleUser(userId);
    }

    @PostMapping("/approveDeposit")
    int approveDeposit(@RequestBody ApproveDepositDto approveDepositDto) {
        return adminService.approveDeposit(approveDepositDto);
    }

    @PutMapping("/updateUser")
    int updateAccount(@Valid @RequestBody UserDto userDto) {
        return adminService.updateUser(userDto);
    }

    @GetMapping("/pendingDeposit")
    List<PendingDeposits> getPendingTransaction() {
        return adminService.getAllPendingDeposits();
    }
    @RequestMapping(value="delete/{id}", method = RequestMethod.DELETE)
    public @ResponseBody
    int deleteUser(@PathVariable("id")  String userId)
    {
        return adminService.deleteUser(userId);
    }
}
