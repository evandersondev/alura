import 'package:flutter/material.dart';

class TransactionListPage extends StatelessWidget {
  const TransactionListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction list'),
      ),
    );
  }
}
