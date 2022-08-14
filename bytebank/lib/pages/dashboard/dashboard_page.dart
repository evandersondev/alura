import 'package:flutter/material.dart';

import 'package:bytebank/pages/deposit/deposit_page.dart';

import '../../themes/colors_app.dart';
import '../../widgets/square_buttom_widget.dart';

import 'widgets/balance_card_widget.dart';
import 'widgets/history_widget.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      floatingActionButton: SquareButtomWidget(
          icon: Icons.add_rounded,
          iconColor: whiteColor,
          backgroundColor: primaryColor,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DepositPage(),
              ),
            );
          }),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            Align(
              alignment: Alignment.topCenter,
              child: BalanceCardWidget(),
            ),
            HistoryWidget()
          ],
        ),
      ),
    );
  }
}
