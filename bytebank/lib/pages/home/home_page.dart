import 'package:bytebank/pages/home/widgets/build_bar_widget.dart';
import 'package:bytebank/pages/home/widgets/floating_buttons_widget.dart';
import 'package:bytebank/themes/constants.dart';
import 'package:flutter/material.dart';

import '../../database/contact_database.dart';
import '../../models/contact_model.dart';
import 'widgets/contact_item_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Byte Bank'),
        centerTitle: true,
        elevation: 1,
      ),
      floatingActionButton: const FloatingButtonsWidget(),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const BuildBarWidget(),
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
