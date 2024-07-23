import 'package:flutter/material.dart';
import 'package:fastpay/screens/LoginPage.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

final TextEditingController name = TextEditingController();
final TextEditingController phoneNumber = TextEditingController();
final TextEditingController email = TextEditingController();
final TextEditingController password = TextEditingController();
final TextEditingController cnic = TextEditingController();
final TextEditingController pinCode = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

String selectedGender = 'Male';

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe7e5e5),
      appBar: AppBar(
        title: Text('Registration Page'),
        backgroundColor: Color(0xffe7e5e5),
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10), // Reduced height
                  TextFormField(
                    controller: phoneNumber,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      } else if (value.length != 11) {
                        return 'Phone number should be 11 digits';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10), // Reduced height
                  TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      // You can add more sophisticated email validation if needed
                      return null;
                    },
                  ),
                  SizedBox(height: 10), // Reduced height
                  Row(
                    children: <Widget>[
                      Text('Gender: ', style: TextStyle(fontSize: 16)),
                      DropdownButton<String>(
                        value: selectedGender,
                        items: <String>['Male', 'Female', 'Other'].map(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            String choice = value!;
                            selectedGender = choice;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10), // Reduced height
                  TextFormField(
                    controller: cnic,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'CNIC (e.g., XXXXX-XXXXXXX-X)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your CNIC';
                      }

                      // Regular expression to match the CNIC format
                      RegExp cnicRegExp = RegExp(r'^\d{5}-\d{7}-\d{1}$');

                      if (!cnicRegExp.hasMatch(value)) {
                        return 'Invalid CNIC format. Use XXXXX-XXXXXXX-X';
                      }

                      return null;
                    },
                  ),

                  SizedBox(height: 10), // Reduced height
                  TextFormField(
                    controller: pinCode,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: '5 digit Pin Code',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your pin code';
                      } else if (value.length != 5) {
                        return 'Pin code should be 5 digits';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        insertrecord();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Registered Successfully!'),
                            duration: Duration(seconds: 2),
                          ),
                        );

                        // Navigate to the login page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffe7e5e5),
                      onPrimary: Colors.black,
                    ),
                    child: Text('Register'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void insertrecord() async {
  // Create Dio instance
  Dio dio = Dio();

  // Define the API endpoint
  String apiUrl = 'http://localhost:8090/api/v1/user/save';

  // Define the data you want to send in the POST request
  Map<String, dynamic> postData = {
    "userName": name.text,
    "phoneNumber": phoneNumber.text,
    "gender": selectedGender.substring(0, 1),
    "CNIC": cnic.text,
    "email": email.text,
    "pinCode": pinCode.text
  };

  try {
    // Make the POST request
    Response response = await dio.post(
      apiUrl,
      data: jsonEncode(postData),
    );

    // Handle the response
    print('Response status: ${response.statusCode}');
    print('Response data: ${response.data}');
  } catch (error) {
    // Handle errors
    print('Error: $error');
  }
}
