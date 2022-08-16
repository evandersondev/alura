import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bytebank/themes/colors_app.dart';
import 'package:bytebank/themes/constants.dart';
import 'package:bytebank/widgets/square_buttom_widget.dart';

// Exemplo de contador usando o BLOC
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void incremet() => emit(state + 1);
  void decremet() => emit(state - 1);
}

class CouterPage extends StatelessWidget {
  const CouterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: const CounterView(),
    );
  }
}

class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COUNTER BLOC'),
        elevation: 0,
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SquareButtomWidget(
            backgroundColor: errorColor,
            icon: Icons.remove_rounded,
            iconColor: whiteColor,
            onTap: context.read<CounterCubit>().decremet,
          ),
          const SizedBox(height: paddingSize / 2),
          SquareButtomWidget(
            backgroundColor: primaryColor,
            icon: Icons.add_rounded,
            iconColor: whiteColor,
            onTap: context.read<CounterCubit>().incremet,
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<CounterCubit, int>(builder: (context, count) {
          return Text(
            '$count',
            style: const TextStyle(
              fontSize: 120,
              fontWeight: FontWeight.w400,
            ),
          );
        }),
      ),
    );
  }
}
