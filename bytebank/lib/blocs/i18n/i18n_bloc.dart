import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';

import 'package:bytebank/models/i18n_model.dart';

import '../../services/i18n_webclient.dart';

import 'i18n_event.dart';
import 'i18n_state.dart';

class I18NBloc extends Bloc<I18NEvent, I18NState> {
  I18NBloc(this.client, this.viewKey) : super(LoadingI18NState()) {
    on<LoadI18NEvent>(realod);
  }

  final I18NWebClient client;
  final String viewKey;
  final storage = LocalStorage('localization_v1.json');

  void realod(LoadI18NEvent event, Emitter<I18NState> emit) async {
    emit(LoadingI18NState());
    await storage.ready;

    final items = storage.getItem(viewKey);

    if (items != null) {
      emit(LoadedI18NState(DashboardPageLazyI18N(I18NModel(items))));
      return;
    }

    await client.findAll(viewKey).then((messages) {
      saveAndRefresh(messages, emit);
    });
  }

  saveAndRefresh(Map<String, dynamic> messages, Emitter<I18NState> emit) {
    storage.setItem(viewKey, messages);
    emit(LoadedI18NState(DashboardPageLazyI18N(I18NModel(messages))));
  }
}
