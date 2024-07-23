package org.example.Response;

import org.example.Entity.UserAccount;

public class LoginMessage {
    private String message;
    private Boolean status;

    private UserAccount userAccount;

    public UserAccount getUserAccount() {
        return userAccount;
    }

    public void setUserAccount(UserAccount userAccount) {
        this.userAccount = userAccount;
    }

    public String getMessage() {
        return message;
    }
    public void setMessage(String message) {
        this.message = message;
    }
    public Boolean getStatus() {
        return status;
    }
    public void setStatus(Boolean status) {
        this.status = status;
    }

    public LoginMessage(String message, Boolean status,UserAccount userAccount) {
        this.message = message;
        this.status = status;
        this.userAccount=userAccount;
    }
}