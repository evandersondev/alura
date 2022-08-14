import 'package:flutter/material.dart';

import 'package:bytebank/themes/constants.dart';

import '../../../models/transaction_model.dart';
import '../../../services/transaction_api.dart';
import '../../transaction/widgets/transaction_item_widget.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TransactionModel>>(
      future: TransactionAPi().getLastFive(),
      initialData: const [],
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(paddingSize),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Last 5 transactions',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          )),
                      const SizedBox(height: paddingSize),
                      ...snapshot.data!.map((e) {
                        return TransactionItemWidget(
                          transaction: e,
                        );
                      }).toList(),
                    ],
                  ),
                );
              }
            }

            return const Text('No transactions found');

          default:
            return const Text('No transactions found');
        }
      },
    );
  }
}
