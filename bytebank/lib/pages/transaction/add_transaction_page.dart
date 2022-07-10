import 'package:bytebank/themes/colors_app.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

import '../../models/contact_model.dart';
import '../../models/transaction_model.dart';
import '../../services/transaction_api.dart';
import '../../themes/constants.dart';
import '../../utils/format_currency_to_double.dart';
import '../../widgets/custom_alert_widget.dart';
import '../../widgets/custom_snackbar_widget.dart';
import '../home/home_page.dart';

class AddTransactionPage extends StatelessWidget {
  AddTransactionPage({
    Key? key,
    required this.contact,
  }) : super(key: key);

  final ContactModel contact;
  final valueController = TextEditingController();
  final passwordController = TextEditingController(text: '');

  Future<void> alertAuthenticateCofirm(BuildContext context) async {
    await CustomAlertWidget.show(
      context: context,
      title: 'Authenticate',
      body: [
        TextFormField(
          obscureText: true,
          maxLength: 4,
          controller: passwordController,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 56, letterSpacing: 12),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
              )),
        ),
      ],
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
        Material(
          borderRadius: BorderRadius.circular(8),
          color: successColor,
          elevation: 0,
          child: InkWell(
            onTap: () async {
              Navigator.pop(context);
              await createTransactionSubmit(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              height: 56,
              width: 100,
              child: const Center(
                  child: Text(
                'CONFIRM',
                style: TextStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> createTransactionSubmit(BuildContext context) async {
    if (valueController.text == '') return;

    final transaction = TransactionModel(
      contact: contact,
      value: formatCurrencyToDouble(valueController.text),
    );

    final response =
        await TransactionAPi.save(transaction, passwordController.text);
    if (response != null) {
      CustomSnackbarWidget.show(
        context: context,
        message: 'Transaction done with success!',
        color: successColor,
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    } else {
      CustomSnackbarWidget.show(
        context: context,
        message: 'Error creating a new contact!',
        color: errorColor,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    const sizeHeight = SizedBox(height: paddingSize);

    return Scaffold(
      appBar: AppBar(
        title: const Text('New transaction'),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(
            children: [
              sizeHeight,
              TextFormField(
                readOnly: true,
                enabled: false,
                initialValue: contact.name,
                decoration: const InputDecoration(
                  labelText: 'Full name',
                  border: OutlineInputBorder(),
                ),
              ),
              sizeHeight,
              TextFormField(
                readOnly: true,
                enabled: false,
                initialValue: contact.account,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Account',
                  border: OutlineInputBorder(),
                ),
              ),
              sizeHeight,
              TextFormField(
                controller: valueController,
                inputFormatters: [
                  CurrencyTextInputFormatter(
                    locale: 'pt_br',
                    decimalDigits: 2,
                    symbol: 'R\$',
                  )
                ],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Value',
                  border: OutlineInputBorder(),
                ),
              ),
              sizeHeight,
              Material(
                color: Theme.of(context).primaryColor,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: InkWell(
                    onTap: () => alertAuthenticateCofirm(context),
                    child: const SizedBox(
                      height: 56,
                      width: double.infinity,
                      child: Center(
                          child: Text(
                        'CREATE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      )),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
