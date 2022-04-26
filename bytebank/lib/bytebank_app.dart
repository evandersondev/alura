import 'package:bytebank/pages/home/home_page.dart';
import 'package:bytebank/themes/colors_app.dart';
import 'package:flutter/material.dart';

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Byte Bank',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primaryColor,
        scaffoldBackgroundColor: whiteColor,
      ),
      home: const HomePage(),
    );
  }
}
