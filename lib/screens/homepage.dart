import 'package:fastpay/screens/sendmoney.dart';
import 'package:fastpay/screens/user.dart';
import 'package:fastpay/screens/viewtransction.dart';
import 'package:flutter/material.dart';

class FastpayHomePage extends StatelessWidget {
  final UserTemp user;

  FastpayHomePage({required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffe7e5e5),
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context)
                .pop(); // Navigate back when the back button is pressed
          },
        ),
      ),
      backgroundColor: Color(0xffe7e5e5),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xffe7e5e5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffe7e5e5),
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Colors.black),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        user.userName.toUpperCase(),
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        user.acc,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 80.0,
                  ), // Adjust the spacing between the rows
                  Text(
                    'Current Balance:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    user.amount,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 250.0,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => sendmoney(
                            user: user,
                          )));
            },
            child: Text(
              'Send',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              primary: Color(0xffe7e5e5), // Set the background color to grey
              onPrimary: Colors.black, // Set the text color to black
              fixedSize: Size(330, 70),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                  color: Colors.black, // Set the border color to black
                  width: 2.0,
                ),
              ),
            ),
          ),

          SizedBox(height: 10.0), // Add some space between the rows
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewTransaction(
                    user: user,
                  ),
                ),
              );
            },
            child: Text(
              'Transaction',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              primary: Color(0xffe7e5e5), // Set the background color to grey
              onPrimary: Colors.black, // Set the text color to black
              fixedSize: Size(330, 70),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                  color: Colors.black, // Set the border color to black
                  width: 2.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
