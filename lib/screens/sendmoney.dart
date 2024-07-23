import 'package:fastpay/screens/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:fastpay/screens/user.dart';
import 'PinCodePage.dart';

class sendmoney extends StatefulWidget {
  final UserTemp user;

  sendmoney({required this.user});

  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<sendmoney> {
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  void dispose() {
    accountNumberController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe7e5e5),
      appBar: AppBar(
        title: Text("Send Money"),
        backgroundColor: Color(0xffe7e5e5),
        foregroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            'Enter Account Number',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          ),
          SizedBox(height: 10),
          TextField(
            controller: accountNumberController,
            textAlign: TextAlign.left,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Account Number",
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Enter Amount',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          ),
          SizedBox(height: 10),
          TextField(
            controller: amountController,
            textAlign: TextAlign.left,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Amount",
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          SizedBox(height: 20),
          // Adding Submit button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  String enteredAccountNumber = accountNumberController.text;
                  String enteredAmount = amountController.text;

                  Transaction mytrans = Transaction(
                      recevieracc: enteredAccountNumber, amount: enteredAmount);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PinCodePage(
                              user: widget.user, transaction: mytrans)));
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffe7e5e5),
                  onPrimary: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  side: BorderSide(color: Colors.black),
                ),
                child: Text("Submit"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
