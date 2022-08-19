import 'package:flutter/material.dart';

import 'package:flutter_tests/app/views/main_view.dart';

import 'app/themes/app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test Course',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: const MainView(),
    );
  }
}
