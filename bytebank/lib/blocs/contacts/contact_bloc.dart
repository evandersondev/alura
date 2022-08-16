import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/contact_database.dart';

import 'contact_event.dart';
import 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(LoadingContact()) {
    on<ContactReload>(reload);
  }

  void reload(ContactReload event, Emitter<ContactState> emit) async {
    emit(LoadingContact());

    final contacts = await ContactDatabase.instance.findAll();
    emit(LoadedContact(contacts: contacts));
    close();
  }
}
