import 'package:flutter/material.dart';

import '../themes/colors_app.dart';

class ResponseDialog extends StatelessWidget {
  final String title;
  final String message;
  final List<Widget>? actions;
  final Icon? icon;
  final Color colorIcon;

  const ResponseDialog({
    this.title = "",
    this.message = "",
    this.icon,
    this.actions,
    this.colorIcon = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Visibility(
        child: Text(title),
        visible: title.isNotEmpty,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      insetPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Visibility(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: icon,
            ),
            visible: icon != null,
          ),
          Visibility(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
            visible: message.isNotEmpty,
          )
        ],
      ),
      actions: actions ?? [],
    );
  }
}

class SuccessDialog extends StatelessWidget {
  final String title;
  final String message;

  const SuccessDialog(
    this.message, {
    this.title = 'Success',
  });

  @override
  Widget build(BuildContext context) {
    return ResponseDialog(
      title: title,
      message: message,
      icon: const Icon(
        Icons.done,
        size: 64,
        color: successColor,
      ),
      colorIcon: Colors.green,
      actions: [
        Material(
          borderRadius: BorderRadius.circular(8),
          color: successColor,
          elevation: 0,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              height: 56,
              width: 100,
              child: const Center(
                  child: Text(
                'OK',
                style: TextStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
          ),
        )
      ],
    );
  }
}

class FailureDialog extends StatelessWidget {
  final String title;
  final String message;

  const FailureDialog(
    this.message, {
    this.title = 'Failure',
  });

  @override
  Widget build(BuildContext context) {
    return ResponseDialog(
      title: title,
      message: message,
      icon: const Icon(
        Icons.warning,
        size: 64,
        color: errorColor,
      ),
      colorIcon: Colors.red,
      actions: [
        Material(
          borderRadius: BorderRadius.circular(8),
          color: errorColor,
          elevation: 0,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              height: 56,
              width: 100,
              child: const Center(
                  child: Text(
                'OK',
                style: TextStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
          ),
        )
      ],
    );
  }
}
