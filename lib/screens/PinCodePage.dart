import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'homepage.dart';
import 'user.dart';

class PinCodePage extends StatefulWidget {
  final UserTemp user;
  final Transaction transaction;

  PinCodePage({required this.user, required this.transaction});

  @override
  _PinCodePageState createState() => _PinCodePageState();
}

class _PinCodePageState extends State<PinCodePage> {
  TextEditingController _pinController = TextEditingController();
  late UserTemp _user;
  late Transaction _transaction;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _transaction = widget.transaction;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe7e5e5),
      appBar: AppBar(
        title: Text("FAST PAY"),
        backgroundColor: Color(0xffe7e5e5),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _pinController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, color: Colors.black),
              decoration: InputDecoration(
                hintText: "Enter PIN",
                hintStyle: TextStyle(color: Colors.black),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              obscureText: true,
              maxLength: 5,
            ),
            SizedBox(height: 16.0),
            buildNumericKeyboard(),
          ],
        ),
      ),
    );
  }

  Widget buildNumericKeyboard() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildNumericKey('1'),
              buildNumericKey('2'),
              buildNumericKey('3'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildNumericKey('4'),
              buildNumericKey('5'),
              buildNumericKey('6'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildNumericKey('7'),
              buildNumericKey('8'),
              buildNumericKey('9'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildBackspaceKey(),
              buildNumericKey('0'),
              buildEnterKey(),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildNumericKey(String digit) {
    return ElevatedButton(
      onPressed: () {
        _pinController.text = _pinController.text + digit;
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(16.0),
        shape: CircleBorder(),
        backgroundColor: Color(0xffe7e5e5),
        foregroundColor: Colors.black,
      ),
      child: Text(
        digit,
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }

  Widget buildEnterKey() {
    return ElevatedButton(
      onPressed: () async {
        String enteredPin = _pinController.text;

        print("Entered PIN: $enteredPin");
        print("User: ${_user.userName}");
        print("Transaction Amount: ${_transaction.amount}");

        if (enteredPin == _user.pincode) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Processing transaction'),
              duration: Duration(seconds: 2),
            ),
          );

          Dio dio = Dio();
          String apiUrl = 'http://localhost:8090/api/v1/user/sendAmount';

          Map<String, dynamic> postData = {
            "senderAccountNumber": _user.acc,
            "receiverAccountNumber": _transaction.recevieracc,
            "amount": _transaction
                .amount, // Replace with actual integer value expected from API
          };

          try {
            Response<int> response = await dio.post(
              apiUrl,
              data: jsonEncode(postData),
            );

            int receivedAmount = response.data ?? 0;

            print('Response status: ${response.statusCode}');
            print('Received Amount: $receivedAmount');

            if (receivedAmount == 0) {
              int value =
                  (int.parse(_user.amount)) - (int.parse(_transaction.amount));
              _user.amount = value.toString();

              print(_user.amount);
              showTransactionSuccessDialog(
                _user.acc,
                _transaction.recevieracc,
                _transaction.amount,
              );
            } else if (receivedAmount == -1) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Transaction failed'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          } catch (error) {
            print('Error: $error');
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Invalid PIN'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(16.0),
        shape: CircleBorder(),
        backgroundColor: Color(0xffe7e5e5),
        foregroundColor: Colors.black,
      ),
      child: Text(
        "Enter",
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }

  Widget buildBackspaceKey() {
    return ElevatedButton(
      onPressed: () {
        String currentText = _pinController.text;
        if (currentText.isNotEmpty) {
          _pinController.text =
              currentText.substring(0, currentText.length - 1);
        }
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(22.0),
        backgroundColor: Color(0xffe7e5e5),
        shape: CircleBorder(),
        foregroundColor: Colors.black,
      ),
      child: Icon(
        Icons.backspace,
        size: 20.0,
      ),
    );
  }

  void showTransactionSuccessDialog(
    String senderAccountNumber,
    String receiverAccountNumber,
    String amount,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Transaction Successful'),
          contentPadding: EdgeInsets.all(8.0), // Adjust the padding as needed
          content: Column(
            mainAxisSize: MainAxisSize.min, // Make the column wrap its content
            children: [
              Text('Sender Account Number: $senderAccountNumber'),
              Text('Receiver Account Number: $receiverAccountNumber'),
              Text('Amount: $amount'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FastpayHomePage(user: _user),
                  ),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
