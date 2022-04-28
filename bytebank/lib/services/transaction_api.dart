import 'dart:convert';

import 'package:bytebank/services/http_service.dart';

import '../models/transaction_model.dart';
import 'base_url.dart';

class TransactionAPi {
  static Future<List<TransactionModel>> findAll() async {
    final client = HttpService.instance;

    final response =
        await client.get(Uri.parse('$baseUrl/transactions')).timeout(
              const Duration(seconds: 5),
            );

    final List<dynamic> json = jsonDecode(response.body);
    final transactions = json
        .map(
          (e) => TransactionModel.fromMap(e),
        )
        .toList();

    return transactions;
  }

  static Future<TransactionModel?> save(
      TransactionModel transaction, String password) async {
    final client = HttpService.instance;

    final response = await client.post(
      Uri.parse('$baseUrl/transactions'),
      headers: {
        'Content-Type': 'application/json',
        'password': password,
      },
      body: transaction.toJson(),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return TransactionModel.fromMap(json);
    }

    return null;
  }
}
