import 'package:flutter/material.dart';
import 'AdminFunction.dart';
import 'RegisterPage.dart';
import 'homepage.dart';

String dummyEmail = "ali@gmail.com";
String dummyPincode = "11111"; // Assuming pincode is a string

class AdminLoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin login page'),
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
                'ADMIN EMAIL',
                textAlign: TextAlign.left,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'ADMIN PIN CODE',
                textAlign: TextAlign.left,
              ),
              TextField(
                controller: pincodeController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'PIN Code',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // String enteredEmail = emailController.text;
                  // String enteredPincode = pincodeController.text;

                  // if (enteredEmail.isNotEmpty && enteredPincode.length == 5) {
                  //   if (enteredPincode == dummyPincode) {
                  //     // Successful login, navigate to AdminFunctionsPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminFunctionsPage(),
                    ),
                  );
                  //   } else {
                  //     // Show a message indicating incorrect PIN code
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       SnackBar(
                  //         content:
                  //             Text('Incorrect PIN code. Please try again.'),
                  //         duration: Duration(seconds: 2),
                  //       ),
                  //     );
                  //   }
                  // } else {
                  //   // Show a message indicating that both fields are required
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //       content: Text(
                  //           'Please enter a valid email and a 5-digit PIN code.'),
                  //       duration: Duration(seconds: 2),
                  //     ),
                  //   );
                  // }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffe7e5e5),
                  onPrimary: Colors.black,
                  side: BorderSide(color: Colors.black),
                ),
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
