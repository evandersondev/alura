import 'dart:convert';

import 'package:bytebank/server/http_client.dart';

import '../models/transaction_model.dart';
import 'base_url.dart';

class TransactionAPi {
  static Future<List<TransactionModel>> findAll() async {
    final client = HttpClient.instance;

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
}
