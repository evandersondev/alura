import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bytebank/blocs/contacts/contact_bloc.dart';

import '../../blocs/contacts/contact_event.dart';
import '../../blocs/contacts/contact_state.dart';
import '../../themes/colors_app.dart';
import '../../themes/constants.dart';
import '../../widgets/square_buttom_widget.dart';

import 'add_contact_page.dart';
import 'widgets/contact_item_widget.dart';

class ContactListContainer extends StatelessWidget {
  const ContactListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) => ContactBloc()..add(ContactReload()),
      child: const ContactListPage(),
    );
  }
}

class ContactListPage extends StatelessWidget {
  const ContactListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      floatingActionButton: SquareButtomWidget(
        icon: Icons.add_rounded,
        iconColor: whiteColor,
        backgroundColor: primaryColor,
        onTap: () => Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (_) => AddContactPage(),
          ),
        )
            .then((_) {
          context.read<ContactBloc>().add(ContactReload());
        }),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<ContactBloc, ContactState>(
          builder: ((context, state) {
            if (state is InitialContact) {
              return const SizedBox();
            }

            if (state is LoadingContact) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is LoadedContact) {
              final contacts = state.contacts;

              return ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                  bottom: paddingSize * 2,
                  left: paddingSize,
                  right: paddingSize,
                  top: paddingSize,
                ),
                itemCount: contacts.length,
                itemBuilder: (context, index) =>
                    ContatcItemWidget(contact: contacts[index]),
              );
            }
            return const Center(
              child: Text('List contacts should be empty.'),
            );
          }),
        ),
      ),
    );
  }
}
