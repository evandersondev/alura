import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bytebank/pages/deposit/deposit_page.dart';
import 'package:bytebank/widgets/bloc_container.dart';

import '../../blocs/i18n/i18n_bloc.dart';
import '../../blocs/i18n/i18n_event.dart';
import '../../blocs/i18n/i18n_state.dart';
import '../../services/i18n_webclient.dart';
import '../../themes/colors_app.dart';
import '../../widgets/square_buttom_widget.dart';

import 'widgets/balance_card_widget.dart';
import 'widgets/history_widget.dart';

class DashboardContainer extends BlocContainer {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => I18NBloc(
        I18NWebClient(),
        'dashboard',
      )..add(LoadI18NEvent()),
      child: const DashBoardPage(),
    );
  }
}

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
      body: BlocBuilder<I18NBloc, I18NState>(
        builder: (context, state) {
          if (state is LoadingI18NState || state is InitialI18NState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LoadedI18NState) {
            final i18n = state.messages;

            return SingleChildScrollView(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topCenter,
                    child: BalanceCardWidget(),
                  ),
                  HistoryWidget(
                    listTransaction: i18n.list_transaction,
                    errorList: i18n.error_list,
                  )
                ],
              ),
            );
          }

          return const Text('Error');
        },
      ),
    );
  }
}
