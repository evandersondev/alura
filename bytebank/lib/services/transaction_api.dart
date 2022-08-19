import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:bytebank/services/http_service.dart';

import '../models/balance_model.dart';
import '../models/transaction_model.dart';

import 'base_url.dart';

class TransactionAPi {
  Future<List<TransactionModel>> findAll() async {
    final client = HttpService().instance;

    final response = await client.get(Uri.parse('$baseUrl/transactions'));

    final List<dynamic> json = jsonDecode(response.body);
    final transactions = json
        .map(
          (e) => TransactionModel.fromMap(e),
        )
        .toList();

    return transactions;
  }

  Future<List<TransactionModel>> getLastFive() async {
    final client = HttpService().instance;

    final response = await client.get(Uri.parse('$baseUrl/transactions'));

    final List<dynamic> json = jsonDecode(response.body);
    final transactions = json
        .map(
          (e) => TransactionModel.fromMap(e),
        )
        .toList();

    return transactions.getRange(0, 5).toList();
  }

  Future<TransactionModel?> save(BuildContext context,
      TransactionModel transaction, String password) async {
    final client = HttpService().instance;

    final balance = Provider.of<BalanceModel>(context, listen: false);

    if (balance.balance <= 0 || balance.balance < transaction.value) {
      throw HttpException(_getMessage(402), 402);
    }

    final response = await client.post(
      Uri.parse('$baseUrl/transactions'),
      headers: {
        'Content-Type': 'application/json',
        'password': password,
      },
      body: transaction.toJson(),
    );

    if (response.statusCode == 200) {
      return TransactionModel.fromMap(jsonDecode(response.body));
    }

    throw HttpException(_getMessage(response.statusCode), response.statusCode);
  }

  String _getMessage(int statusCode) {
    if (_statusCodeResponse.containsKey(statusCode)) {
      return _statusCodeResponse[statusCode]!;
    }

    return 'Unknown error';
  }

  void throwHttpError(int statusCode) =>
      throw Exception(_statusCodeResponse[statusCode]);

  static final Map<int, String> _statusCodeResponse = {
    400: 'There was an error submitting transaction',
    401: 'Authentication failed',
    402: 'Balance is not enough',
    409: 'Transaction already exists',
  };
}

class HttpException implements Exception {
  final String message;
  final int statusCode;

  HttpException(this.message, this.statusCode);
}
