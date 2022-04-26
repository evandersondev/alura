import 'package:flutter/material.dart';

class CustomSnackbarWidget {
  static show(
      {required BuildContext context,
      required String message,
      required Color color}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
      ),
    );
  }
}
