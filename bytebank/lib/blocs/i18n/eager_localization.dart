import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bytebank/blocs/i18n/locale.dart';

class PageI18N {
  late String _language;

  PageI18N(BuildContext context) {
    _language = BlocProvider.of<CurrentLocaleCubit>(context).state;
  }

  String localize(Map<String, String> map) {
    assert(map.containsKey(_language));

    return map[_language]!;
  }
}
