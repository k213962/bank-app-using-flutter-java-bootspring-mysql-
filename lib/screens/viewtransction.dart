import 'package:dio/dio.dart';
import 'package:fastpay/screens/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewTransaction extends StatefulWidget {
  final UserTemp user;

  ViewTransaction({required this.user});

  @override
  _ViewTransactionState createState() => _ViewTransactionState();
}

class _ViewTransactionState extends State<ViewTransaction> {
  // Example API endpoint
  final String apiUrl = 'http://localhost:8090/api/v1/user/transaction';

  // Create a Dio instance
  final Dio dio = Dio();

  List<Map<String, dynamic>> transactions = [];

  // Function to make a GET request
  Future<void> fetchData(UserTemp user) async {
    final String finalUrl = apiUrl + '/' + user.userId.toString();
    print(finalUrl);
    try {
      // Making a GET request
      final response = await dio.get(finalUrl);

      if (response.statusCode == 200) {
        setState(() {
          transactions = List<Map<String, dynamic>>.from(response.data);
        });
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error loading data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Transactions'),
        backgroundColor: Color(0xffe7e5e5),
        foregroundColor: Colors.black,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await fetchData(widget.user);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (var transaction in transactions)
                Container(
                  color: Color(0xffe7e5e5), // Background color same as app bar
                  child: ListTile(
                    title: Text(
                        'Receiver Name: ${transaction['receiverUserName']}'),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Amount: ${transaction['transactionAmount']}',
                            textAlign: TextAlign.left),
                        Text(
                            'Date: ${_formatDate(transaction['transactionDate'])}',
                            textAlign: TextAlign.right),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    return '${dateTime.day}-${dateTime.month}-${dateTime.year}';
  }
}
