import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:bytebank/pages/main_page.dart';
import 'package:bytebank/themes/colors_app.dart';

import 'models/balance_model.dart';

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BalanceModel>(
          create: (_) => BalanceModel(balance: 800),
        ),
      ],
      child: MaterialApp(
        title: 'Byte Bank',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: primaryColor,
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          appBarTheme: const AppBarTheme(centerTitle: true),
        ),
        home: const MainPage(),
      ),
    );
  }
}
