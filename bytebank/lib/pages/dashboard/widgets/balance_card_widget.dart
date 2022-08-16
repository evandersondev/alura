import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:bytebank/models/balance_model.dart';
import 'package:bytebank/themes/colors_app.dart';

import '../../../models/name_model.dart';
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
          BlocBuilder<NameCubit, String>(
            builder: (context, name) {
              return Text(
                'Hi, $name your balance'.toUpperCase(),
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              );
            },
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
          const SizedBox(height: paddingSize / 2),
          Divider(
            thickness: 2,
            color: successColor.withOpacity(0.1),
          ),
        ],
      ),
    );
  }
}
