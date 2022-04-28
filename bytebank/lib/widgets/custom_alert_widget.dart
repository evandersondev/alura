import 'package:flutter/material.dart';

class CustomAlertWidget {
  static Future<void> show({
    required BuildContext context,
    required String title,
    required List<Widget> body,
    required List<Widget> actions,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          insetPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            child: ListBody(children: body),
          ),
          actions: actions,
        );
      },
    );
  }
}
