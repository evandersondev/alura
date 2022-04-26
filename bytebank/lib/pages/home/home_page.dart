import 'package:bytebank/pages/contact/add_contact_page.dart';
import 'package:bytebank/pages/home/widgets/square_buttom_widget.dart';
import 'package:bytebank/themes/colors_app.dart';
import 'package:bytebank/themes/constants.dart';
import 'package:flutter/material.dart';

import '../../database/contact_database.dart';
import '../../models/contact_model.dart';
import '../transaction/transaction_page.dart';
import 'widgets/contact_item_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ByteBank'),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: const FloatingButtons(),
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
                  padding: const EdgeInsets.only(bottom: paddingSize * 2),
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

class FloatingButtons extends StatelessWidget {
  const FloatingButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SquareButtomWidget(
          icon: Icons.description_outlined,
          iconSize: 28,
          iconColor: darkColor,
          backgroundColor: secondaryColor,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const TransactionListPage(),
            ),
          ),
        ),
        const SizedBox(height: paddingSize),
        SquareButtomWidget(
          icon: Icons.add_rounded,
          iconSize: 38,
          iconColor: whiteColor,
          backgroundColor: primaryColor,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AddContactPage(),
            ),
          ),
        ),
      ],
    );
  }
}
