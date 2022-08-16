import '../../models/i18n_model.dart';

abstract class I18NState {}

class InitialI18NState extends I18NState {}

class LoadingI18NState extends I18NState {}

class LoadedI18NState extends I18NState {
  final DashboardPageLazyI18N messages;
  LoadedI18NState(this.messages);
}

class ErrorI18NState extends I18NState {}
