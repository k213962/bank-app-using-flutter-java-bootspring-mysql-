package org.example.Dto;


public class LoginDto {

    private String email;
    private String pinCode;

    public String getEmail() {
        return this.email;
    }

    public String getPinCode() {
        return this.pinCode;
    }

    public LoginDto(String email, String pinCode) {
        this.email = email;
        this.pinCode = pinCode;
    }
}
