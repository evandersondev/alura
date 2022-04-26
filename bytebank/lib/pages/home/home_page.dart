import 'package:bytebank/database/contact_database.dart';
import 'package:bytebank/models/contact_model.dart';
import 'package:bytebank/pages/contact/add_contact_page.dart';
import 'package:flutter/material.dart';

import 'widgets/contact_item_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ByteBank'),
        centerTitle: true,
        elevation: 1,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute<ContactModel>(
              builder: (_) {
                return AddContactPage();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      resizeToAvoidBottomInset: true,
      body: FutureBuilder<List<ContactModel>>(
          initialData: const [],
          future: ContactDatabase.findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                return ListView.separated(
                  itemCount: snapshot.data?.length ?? 0,
                  separatorBuilder: (_, __) => const Divider(
                    indent: 16,
                    endIndent: 16,
                  ),
                  itemBuilder: (context, index) =>
                      ContatcItemWidget(contact: snapshot.data![index]),
                );
              default:
                return Container();
            }
          }),
    );
  }
}
