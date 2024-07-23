import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:dio/dio.dart';
import 'package:fastpay/screens/user.dart';
import 'package:flutter/material.dart';

import 'LoginPage.dart';

class AdminFunctionsPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Functions'),
        backgroundColor: Color(0xffe7e5e5),
        foregroundColor: Colors.black,
      ),
      backgroundColor: Color(0xffe7e5e5),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.end, // Align buttons to the right
                children: [
                  Expanded(
                    child: Text(
                      '1. View Record?',
                      style: TextStyle(fontSize: 20), // Increased font size
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showViewRecordDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffe7e5e5),
                      onPrimary: Colors.black,
                      side: BorderSide(color: Colors.black),
                      minimumSize: Size(100, 40), // Increased button size
                    ),
                    child: Text(
                      'View',
                      style: TextStyle(fontSize: 20), // Increased font size
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.end, // Align buttons to the right
                children: [
                  Expanded(
                    child: Text(
                      '2. Insert Customer?',
                      style: TextStyle(fontSize: 20), // Increased font size
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showInsertRecordDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffe7e5e5),
                      onPrimary: Colors.black,
                      side: BorderSide(color: Colors.black),
                      minimumSize: Size(100, 40), // Increased button size
                    ),
                    child: Text(
                      'Insert',
                      style: TextStyle(fontSize: 20), // Increased font size
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.end, // Align buttons to the right
                children: [
                  Expanded(
                    child: Text(
                      '3. Update Record?',
                      style: TextStyle(fontSize: 20), // Increased font size
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showUpdateAccountNumberDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffe7e5e5),
                      onPrimary: Colors.black,
                      side: BorderSide(color: Colors.black),
                      minimumSize: Size(100, 40), // Increased button size
                    ),
                    child: Text(
                      'Update',
                      style: TextStyle(fontSize: 20), // Increased font size
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.end, // Align buttons to the right
                children: [
                  Expanded(
                    child: Text(
                      '4. Delete Record?',
                      style: TextStyle(fontSize: 20), // Increased font size
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showDeleteRecordDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffe7e5e5),
                      onPrimary: Colors.black,
                      side: BorderSide(color: Colors.black),
                      minimumSize: Size(100, 40), // Increased button size
                    ),
                    child: Text(
                      'Delete',
                      style: TextStyle(fontSize: 20), // Increased font size
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

  void _showInsertRecordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Insert Record'),
          content: _InsertRecordForm(),
        );
      },
    );
  }

  void _showUpdateAccountNumberDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Account Number'),
          content: _UpdateRecordForm(),
        );
      },
    );
  }

  void _showUpdateRecordDialog(BuildContext context, String accountNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Record'),
          content: _UpdateRecordForm(),
        );
      },
    );
  }

  void _showDeleteRecordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Record'),
          content: _DeleteRecordForm(),
        );
      },
    );
  }
}

class _InsertRecordForm extends StatefulWidget {
  @override
  _InsertRecordFormState createState() => _InsertRecordFormState();
}

class _InsertRecordFormState extends State<_InsertRecordForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController cnicController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(labelText: 'Name'),
        ),
        TextFormField(
          controller: phoneNumberController,
          decoration: InputDecoration(labelText: 'Phone Number'),
        ),
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(labelText: 'Email'),
        ),
        TextFormField(
          controller: genderController,
          decoration: InputDecoration(labelText: 'Gender'),
        ),
        TextFormField(
          controller: cnicController,
          decoration: InputDecoration(labelText: 'CNIC'),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(13),
            _CnicFormatter(),
          ],
        ),
        TextFormField(
          controller: pinCodeController,
          decoration: InputDecoration(labelText: 'Pin Code'),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly, // Allow only numeric input
            LengthLimitingTextInputFormatter(5), // Restrict to 5 digits
          ],
        ),
        ElevatedButton(
          onPressed: () {
            // TODO: Implement logic to submit the form
            submitForm();
          },
          child: Text('Submit'),
        ),
      ],
    );
  }

  void submitForm() async {
    // Retrieve data from controllers
    String name = nameController.text;
    String phoneNumber = phoneNumberController.text;
    String email = emailController.text;
    String gender = genderController.text;
    String cnic = cnicController.text;
    String pinCode = pinCodeController.text;

    Dio dio = Dio();

    // Define the API endpoint
    String apiUrl = 'http://localhost:8090/api/v1/user/save';

    // Define the data you want to send in the POST request
    Map<String, dynamic> postData = {
      "userName": name,
      "phoneNumber": phoneNumber,
      "gender": gender.substring(0, 1),
      "CNIC": cnic,
      "email": email,
      "pinCode": pinCode
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

      if (response.statusCode == 200 &&
          response.data is int &&
          response.data > 0) {
        // If the response is a positive integer, show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Record added successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // If the response is not a positive integer, show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unable to add record. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      // Handle errors
      print('Error: $error');

      // If there's an error, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }

    // Optionally, you can reset the form fields after submission
    nameController.clear();
    phoneNumberController.clear();
    emailController.clear();
    genderController.clear();
    cnicController.clear();
    pinCodeController.clear();

    // Close the form
    Navigator.of(context).pop();
  }
}

class _CnicFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = _formatCnic(newValue.text);
    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  String _formatCnic(String value) {
    value = value.replaceAll(RegExp(r'\D'), ''); // Remove non-digits
    if (value.length > 5) {
      value = value.substring(0, 5) +
          '-' +
          value.substring(5, 12) +
          '-' +
          value.substring(12);
    }
    return value;
  }
}

class _UpdateRecordForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userId = '';
    String userName = '';
    String gender = '';
    String cnic = '';
    String email = '';
    String pinCode = '';
    String phoneNumber = ''; // Added field for Phone Number

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'User ID'),
          onChanged: (value) {
            userId = value;
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'User Name'),
          onChanged: (value) {
            userName = value;
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Gender'),
          onChanged: (value) {
            gender = value;
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'CNIC'),
          onChanged: (value) {
            cnic = value;
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Email'),
          onChanged: (value) {
            email = value;
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Pin Code'),
          onChanged: (value) {
            pinCode = value;
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Phone Number'),
          onChanged: (value) {
            phoneNumber = value;
          },
        ),
        ElevatedButton(
          onPressed: () {
            // TODO: Implement logic to update the record
            saveRecord(context, userId, userName, gender, cnic, email, pinCode,
                phoneNumber);
            Navigator.of(context).pop();
          },
          child: Text('Update'),
        ),
      ],
    );
  }

  Future<void> saveRecord(
      BuildContext context,
      String userId,
      String userName,
      String gender,
      String cnic,
      String email,
      String pinCode,
      String phoneNumber) async {
    print(userId + userName + gender + cnic + email + pinCode + phoneNumber);
    Dio dio = Dio();
    String url = "http://localhost:8090/api/v1/admin/updateUser";
    Map<String, dynamic> postData = {
      "email": email,
      "pinCode": pinCode,
      "userName": userName,
      "gender": gender.substring(0, 1),
      "CNIC": cnic,
      "userId": userId,
      "phoneNumber": phoneNumber,
    };

    try {
      Response<int> response = await dio.put(
        url,
        data: jsonEncode(postData),
      );
      int check = response.data ?? -1;

      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        SnackBar(
          content: check != -1
              ? Text('Updation successful')
              : Text('No record found'),
          duration: Duration(seconds: 3),
        ),
      );
    } catch (error) {
      print(error);
    }
  }
}

void _showViewRecordDialog(BuildContext context) async {
  String accountNumber = '';

  showDialog(
    context: context,
    builder: (BuildContext outerContext) {
      return AlertDialog(
        title: Text('View Record'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Account Number'),
              onChanged: (value) {
                accountNumber = value;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                Dio dio = Dio();
                String apiUrl = 'http://localhost:8090/api/v1/admin/user/';
                String finalurl = apiUrl + accountNumber;

                try {
                  Response response = await dio.get(finalurl);
                  print('Response data: ${response.data}');

                  if (response.statusCode == 200) {
                    if (response.data != null) {
                      Map<String, dynamic> responseData =
                          Map<String, dynamic>.from(response.data);

                      // Use the outer context when showing the second AlertDialog
                      showDialog(
                        context: outerContext,
                        builder: (BuildContext innerContext) {
                          return AlertDialog(
                            title: Text('User Information'),
                            content: Column(
                              children: [
                                Text('User ID: ${responseData['userId']}'),
                                Text('User Name: ${responseData['userName']}'),
                                Text(
                                    'Phone Number: ${responseData['phoneNumber']}'),
                                Text('Pin Code: ${responseData['pinCode']}'),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(innerContext).pop();
                                },
                                child: Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      _showErrorMessage(outerContext, 'Response data is null');
                    }
                  } else {
                    _showErrorMessage(outerContext, 'Failed to fetch data');
                  }
                } catch (error) {
                  print('Error: $error');
                  _showErrorMessage(outerContext, 'Error fetching data');
                }

                Navigator.of(outerContext).pop(); // Close the outer dialog
              },
              child: Text('View'),
            ),
          ],
        ),
      );
    },
  );
}

void _showErrorMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

class _DeleteRecordForm extends StatefulWidget {
  @override
  _DeleteRecordFormState createState() => _DeleteRecordFormState();
}

class _DeleteRecordFormState extends State<_DeleteRecordForm> {
  String accountNumber = '';

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Record'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'Are you sure you want to delete the record of Account Number: $accountNumber?'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop(); // Close confirmation dialog
                      Navigator.of(context).pop();
                      String url = "http://localhost:8090/api/v1/admin/delete/";
                      String Finalurl = url + accountNumber;
                      Dio dio = Dio();
                      try {
                        Response response = await dio.delete(Finalurl);
                      } catch (error) {
                        print(error);
                      }
                    },
                    child: Text('Yes'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close confirmation dialog
                    },
                    child: Text('No'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Account Number'),
          onChanged: (value) {
            setState(() {
              accountNumber = value;
            });
          },
        ),
        ElevatedButton(
          onPressed: () {
            _showDeleteConfirmationDialog();
          },
          child: Text('Delete'),
        ),
      ],
    );
  }
}
