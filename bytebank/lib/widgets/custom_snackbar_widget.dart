import 'package:bytebank/themes/constants.dart';
import 'package:flutter/material.dart';

class CustomSnackbarWidget {
  static show(
      {required BuildContext context,
      required String message,
      required Color color}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.symmetric(
            vertical: paddingSize * 2, horizontal: paddingSize),
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        behavior: SnackBarBehavior.fixed,
        backgroundColor: color,
      ),
    );
  }
}
