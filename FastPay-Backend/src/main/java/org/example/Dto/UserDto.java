package org.example.Dto;

public class UserDto{
    private int userId;
    private String userName;
    private String pinCode;
    private String phoneNumber;
    private char gender;
    private String CNIC;
    private String email;

    public UserDto(int userId, String userName, String phoneNumber, char gender, String CNIC, String email, @org.jetbrains.annotations.NotNull String pinCode) {

        if (pinCode.length() == 5 && pinCode.matches("\\d+")) {
            this.userId = userId;
            this.userName = userName;
            this.gender = gender;
            this.CNIC = CNIC;
            this.phoneNumber = phoneNumber;
            this.email = email;
            this.pinCode = pinCode;
        }
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public char getGender() {
        return gender;
    }

    public void setGender(char gender) {
        this.gender = gender;
    }
    public String getCNIC() {
        return CNIC;
    }

    public void setCNIC(String CNIC) {
        this.CNIC = CNIC;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPinCode() {
        return pinCode;
    }

    public void setPinCode(String pinCode) {
        this.pinCode = pinCode;
    }


    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
}



