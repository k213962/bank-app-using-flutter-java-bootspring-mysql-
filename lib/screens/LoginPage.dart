import 'package:fastpay/screens/user.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'AdminLogin.dart';
import 'RegisterPage.dart';
import 'homepage.dart';

class ApiResponse {
  final String message;
  final bool status;
  final UserAccount userAccount;

  ApiResponse({
    required this.message,
    required this.status,
    required this.userAccount,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json['message'],
      status: json['status'],
      userAccount: UserAccount.fromJson(json['userAccount']),
    );
  }
}

class UserAccount {
  final String accountNo;
  final double amount;
  final User user;

  UserAccount({
    required this.accountNo,
    required this.amount,
    required this.user,
  });

  factory UserAccount.fromJson(Map<String, dynamic> json) {
    return UserAccount(
      accountNo: json['accountNo'],
      amount: json['amount'].toDouble(),
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int userId;
  final String userName;
  final String phoneNumber;
  final String pinCode;

  User({
    required this.userId,
    required this.userName,
    required this.phoneNumber,
    required this.pinCode,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      userName: json['userName'],
      phoneNumber: json['phoneNumber'],
      pinCode: json['pinCode'],
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        backgroundColor: Color(0xffe7e5e5),
        foregroundColor: Colors.black,
      ),
      backgroundColor: Color(0xffe7e5e5),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'EMAIL',
                textAlign: TextAlign.left,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'PIN CODE',
                textAlign: TextAlign.left,
              ),
              TextFormField(
                controller: pinCodeController,
                keyboardType: TextInputType.number,
                maxLength: 5,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'PIN Code',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Login(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffe7e5e5),
                  onPrimary: Colors.black,
                  side: BorderSide(color: Colors.black),
                ),
                child: Text('Login'),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  SizedBox(width: 5),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Signup',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 200),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Login as admin?"),
                  SizedBox(width: 5),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminLoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void Login(BuildContext context) async {
    Dio dio = Dio();
    String apiUrl = 'http://localhost:8090/api/v1/user/login';

    Map<String, dynamic> postData = {
      "email": emailController.text,
      "pinCode": pinCodeController.text,
    };

    try {
      Response response = await dio.post(
        apiUrl,
        data: jsonEncode(postData),
      );
      print(response.data);
      ApiResponse apiResponse = ApiResponse.fromJson(response.data);

      bool status = apiResponse.status;

      print('Response status: ${response.statusCode}');
      print('Response data: ${apiResponse}');

      if (apiResponse.status) {
        // Continue with successful login logic
        String userId = apiResponse.userAccount.user.userId.toString();
        String userName = apiResponse.userAccount.user.userName.toString();
        String acc = apiResponse.userAccount.accountNo.toString();
        String amount = apiResponse.userAccount.amount.toString();
        String pincode = apiResponse.userAccount.user.pinCode.toString();
        String phonenumber =
            apiResponse.userAccount.user.phoneNumber.toString();
        UserTemp user = UserTemp(
          userId: userId,
          userName: userName,
          acc: acc,
          amount: amount,
          pincode: pincode,
          phoneNumber: phonenumber,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FastpayHomePage(
              user: user,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid email or PIN code'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
