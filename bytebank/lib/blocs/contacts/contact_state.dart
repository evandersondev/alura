import '../../models/contact_model.dart';

abstract class ContactState {}

class InitialContact extends ContactState {}

class LoadingContact extends ContactState {}

class LoadedContact extends ContactState {
  final List<ContactModel> contacts;

  LoadedContact({
    required this.contacts,
  });
}

class ErrorContact extends ContactState {}
