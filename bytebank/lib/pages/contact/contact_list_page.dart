import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../database/contact_database.dart';
import '../../models/contact_model.dart';
import '../../themes/colors_app.dart';
import '../../themes/constants.dart';
import '../../widgets/square_buttom_widget.dart';

import 'add_contact_page.dart';
import 'widgets/contact_item_widget.dart';

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
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AddContactPage(),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder<List<ContactModel>>(
                initialData: const [],
                future: ContactDatabase.findAll(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case ConnectionState.done:
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(
                          bottom: paddingSize * 2,
                          left: paddingSize,
                          right: paddingSize,
                          top: paddingSize,
                        ),
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, index) =>
                            ContatcItemWidget(contact: snapshot.data![index]),
                      );
                    default:
                      return Container();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
