class UserTemp {
  String userId;
  String userName;
  String acc;
  String amount;
  String pincode;
  String phoneNumber;

  // Parameterized constructor
  UserTemp({
    required this.userId,
    required this.userName,
    required this.acc,
    required this.amount,
    required this.pincode,
    required this.phoneNumber,
  });
}

class Transaction {
  String recevieracc;
  String amount;

  Transaction({
    required this.recevieracc,
    required this.amount,
  });
}
