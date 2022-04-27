import 'package:bytebank/themes/colors_app.dart';
import 'package:bytebank/themes/constants.dart';
import 'package:flutter/material.dart';

import 'package:bytebank/models/transaction_model.dart';
import 'package:intl/intl.dart';

class TransactionItemWidget extends StatelessWidget {
  TransactionItemWidget({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  final TransactionModel transaction;
  final currencyFormatter =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: paddingSize),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        visualDensity: VisualDensity.comfortable,
        leading: const Icon(
          Icons.monetization_on_rounded,
          color: darkColor,
        ),
        title: Text(
          transaction.contact.name.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text('Valor: ${currencyFormatter.format(transaction.value)}'),
      ),
    );
  }
}
