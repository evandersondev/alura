import 'package:flutter/material.dart';

import 'package:bytebank/pages/transaction/widgets/centered_message.dart';
import 'package:bytebank/services/transaction_api.dart';
import 'package:bytebank/themes/constants.dart';

import '../../models/transaction_model.dart';

import 'widgets/transaction_item_widget.dart';

class TransactionListPage extends StatelessWidget {
  const TransactionListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Transaction list'),
        ),
        body: FutureBuilder<List<TransactionModel>>(
          future: TransactionAPi().findAll(),
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
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      padding: const EdgeInsets.all(paddingSize),
                      itemBuilder: (context, index) {
                        return TransactionItemWidget(
                          transaction: snapshot.data![index],
                        );
                      },
                    );
                  }
                }

                return const CenteredMessage(
                  'No transactions found',
                  icon: Icons.warning,
                );

              default:
                return const CenteredMessage('Unknow error');
            }
          },
        ));
  }
}
