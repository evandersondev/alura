import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:bytebank/pages/main_page.dart';
import 'package:bytebank/themes/colors_app.dart';

import 'blocs/i18n/locale.dart';
import 'models/balance_model.dart';

class LogObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    print('${bloc.runtimeType} > $change');
    super.onChange(bloc, change);
  }
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Bloc.observer = LogObserver();

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
        home: LocalizationContainer(child: const MainContainer()),
      ),
    );
  }
}
