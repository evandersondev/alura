import 'dart:async';

import 'package:flutter/material.dart';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:toast/toast.dart';
import 'package:uuid/uuid.dart';

import 'package:bytebank/themes/colors_app.dart';

import '../../models/contact_model.dart';
import '../../models/transaction_model.dart';
import '../../services/transaction_api.dart';
import '../../themes/constants.dart';
import '../../utils/format_currency_to_double.dart';
import '../../widgets/custom_alert_widget.dart';
import '../../widgets/custom_progress_widget.dart';
import '../../widgets/response_dialog.dart';
import '../home/home_page.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({
    Key? key,
    required this.contact,
  }) : super(key: key);

  final ContactModel contact;

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final transactionId = const Uuid().v4();
  final valueController = TextEditingController();
  final passwordController = TextEditingController(text: '');

  bool _isSending = false;

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
              FocusManager.instance.primaryFocus?.unfocus();
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
    final transaction = TransactionModel(
      id: transactionId,
      contact: widget.contact,
      value: formatCurrencyToDouble(valueController.text),
    );

    final response = await send(
      context,
      transaction: transaction,
      password: passwordController.text,
    );

    if (response != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return const SuccessDialog(
              'Transaction done with success!',
            );
          });

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    }
  }

  Future<TransactionModel?> send(
    BuildContext context, {
    required TransactionModel transaction,
    required String password,
  }) async {
    setState(() {
      _isSending = true;
    });

    try {
      final response = await TransactionAPi().save(transaction, password);
      return response;
    } on HttpException catch (e) {
      if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
        await FirebaseCrashlytics.instance
            .setCustomKey('exception', e.toString());
        await FirebaseCrashlytics.instance
            .setCustomKey('http_code', '${e.statusCode}');
        await FirebaseCrashlytics.instance
            .setCustomKey('http_body', transaction.toString());
        await FirebaseCrashlytics.instance.recordError(e, null);
      }

      showFailureMessage(context, message: e.message);
    } on TimeoutException catch (e) {
      if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
        await FirebaseCrashlytics.instance
            .setCustomKey('exception', e.toString());
        await FirebaseCrashlytics.instance
            .setCustomKey('http_body', transaction.toString());
        await FirebaseCrashlytics.instance.recordError(e, null);
      }

      showFailureMessage(context, message: e.message!);
    } on Exception catch (e) {
      if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
        await FirebaseCrashlytics.instance
            .setCustomKey('exception', e.toString());
        await FirebaseCrashlytics.instance
            .setCustomKey('http_body', transaction.toString());
        await FirebaseCrashlytics.instance.recordError(e, null);
      }

      showFailureMessage(context);
    } finally {
      setState(() {
        _isSending = false;
        passwordController.text = '';
      });
    }
    return null;
  }

  void showFailureMessage(BuildContext context,
      {String message = 'Unknown error'}) {
    // showDialog(
    //     context: context,
    //     builder: (contextDialog) {
    //       return FailureDialog(message);
    //     });

    // CustomSnackbarWidget.show(
    //     context: context, message: message, color: errorColor);

    // showToast(message, gravity: Toast.bottom);

    showDialog(
        context: context,
        builder: (_) => NetworkGiffDialog(
              image:
                  Image.asset('lib/assets/giffs/error.gif', fit: BoxFit.cover),
              title: const Text('OPS',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
              description: Text(message, textAlign: TextAlign.center),
              entryAnimation: EntryAnimation.top,
              onOkButtonPressed: () {},
            ));
  }

  void showToast(String msg, {int? duration = 5, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }

  @override
  Widget build(BuildContext context) {
    const sizeHeight = SizedBox(height: paddingSize);
    print('Transaction id: $transactionId');

    ToastContext().init(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('New transaction'),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(
            children: [
              Visibility(
                visible: _isSending,
                child: const Padding(
                  padding: EdgeInsets.all(paddingSize * 2),
                  child: CustomProgressWidget(message: 'Sending ...'),
                ),
              ),
              sizeHeight,
              TextFormField(
                readOnly: true,
                enabled: false,
                initialValue: widget.contact.name,
                decoration: const InputDecoration(
                  labelText: 'Full name',
                  border: OutlineInputBorder(),
                ),
              ),
              sizeHeight,
              TextFormField(
                readOnly: true,
                enabled: false,
                initialValue: widget.contact.account,
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
