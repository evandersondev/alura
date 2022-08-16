import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/bloc_container.dart';

class LocalizationContainer extends BlocContainer {
  LocalizationContainer({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: CurrentLocaleCubit(),
      child: child,
    );
    // return BlocProvider<CurrentLocaleCubit>(
    //   create: (_) => CurrentLocaleCubit(),
    //   child: child,
    // );
  }
}

class CurrentLocaleCubit extends Cubit<String> {
  CurrentLocaleCubit() : super('en_us');
}
