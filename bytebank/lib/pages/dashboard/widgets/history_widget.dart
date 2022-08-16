import 'package:flutter/material.dart';

import 'package:bytebank/themes/constants.dart';

import '../../../models/transaction_model.dart';
import '../../../services/transaction_api.dart';
import '../../transaction/widgets/transaction_item_widget.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({
    Key? key,
    required this.listTransaction,
    required this.errorList,
  }) : super(key: key);

  final String listTransaction;
  final String errorList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(paddingSize),
          child: Text(
            listTransaction,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        FutureBuilder<List<TransactionModel>>(
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

                return Text(errorList);

              default:
                return Text(errorList);
            }
          },
        ),
      ],
    );
  }
}
