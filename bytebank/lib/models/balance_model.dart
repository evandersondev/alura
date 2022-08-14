import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class BalanceModel extends ChangeNotifier {
  double balance;

  BalanceModel({
    required this.balance,
  });

  String get toCurrency =>
      NumberFormat.currency(locale: 'en_US', symbol: '\$').format(balance);

  void deposit(double? value) {
    if (value != null && value <= 0) {
      return;
    }

    balance += value!;
    notifyListeners();
  }

  void transfer(double value) {
    balance -= value;
    notifyListeners();
  }
}
