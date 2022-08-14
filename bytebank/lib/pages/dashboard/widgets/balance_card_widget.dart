import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:bytebank/models/balance_model.dart';

import '../../../themes/constants.dart';

class BalanceCardWidget extends StatelessWidget {
  const BalanceCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: paddingSize,
        vertical: paddingSize * 2,
      ),
      child: Column(
        children: [
          Text(
            'My Balance'.toUpperCase(),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: paddingSize / 2),
          Consumer<BalanceModel>(
            builder: (context, value, child) {
              return Text(
                value.toCurrency,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
