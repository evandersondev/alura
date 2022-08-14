import 'package:flutter/material.dart';

import '../themes/constants.dart';

class CustomProgressWidget extends StatelessWidget {
  const CustomProgressWidget({Key? key, this.message = 'Loading'})
      : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: paddingSize * 2),
          Text(message,
              style: const TextStyle(
                fontSize: 18,
              )),
        ],
      ),
    );
  }
}
