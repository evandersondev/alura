import 'package:flutter/material.dart';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:provider/provider.dart';

import 'package:bytebank/models/balance_model.dart';
import 'package:bytebank/utils/format_currency_to_double.dart';

import '../../themes/constants.dart';

class DepositPage extends StatelessWidget {
  DepositPage({Key? key}) : super(key: key);

  final _depositController = TextEditingController();

  void _deposit(BuildContext context, BalanceModel balance) {
    final value = formatCurrencyToDouble(_depositController.text);
    balance.deposit(value);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    const sizeHeight = SizedBox(height: paddingSize);

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Deposit'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(
            children: [
              sizeHeight,
              TextFormField(
                controller: _depositController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  CurrencyTextInputFormatter(
                    locale: 'en_US',
                    decimalDigits: 2,
                    symbol: '\$',
                  )
                ],
                decoration: const InputDecoration(
                  labelText: 'Value to deposit',
                  border: OutlineInputBorder(),
                ),
              ),
              sizeHeight,
              Consumer<BalanceModel>(builder: (context, value, child) {
                return Material(
                  color: Theme.of(context).primaryColor,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: InkWell(
                      onTap: () => _deposit(context, value),
                      child: const SizedBox(
                        height: 56,
                        width: double.infinity,
                        child: Center(
                            child: Text(
                          'DEPOSIT',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        )),
                      ),
                    ),
                  ),
                );
              })
            ],
          )),
    );
  }
}
