import 'package:bytebank/database/contact_database.dart';
import 'package:bytebank/pages/home/home_page.dart';
import 'package:bytebank/themes/constants.dart';
import 'package:bytebank/widgets/custom_snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../models/contact_model.dart';
import '../../themes/colors_app.dart';
import '../../utils/input_masks.dart';

class AddContactPage extends StatelessWidget {
  AddContactPage({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final agencyController = TextEditingController();
  final accountController = TextEditingController();

  void addContactSubmit(BuildContext context) async {
    final contact = ContactModel(
      id: const Uuid().v4(),
      name: nameController.text,
      agency: agencyController.text,
      account: accountController.text,
    );

    final response = await ContactDatabase.save(contact);
    if (response != 0) {
      CustomSnackbarWidget.show(
        context: context,
        message: 'Contact create with success!',
        color: successColor,
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    } else {
      CustomSnackbarWidget.show(
        context: context,
        message: 'Error creating a new contact!',
        color: errorColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const sizeHeight = SizedBox(height: paddingSize);

    return Scaffold(
      appBar: AppBar(
        title: const Text('New contact'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(
            children: [
              sizeHeight,
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full name',
                  border: OutlineInputBorder(),
                ),
              ),
              sizeHeight,
              TextFormField(
                controller: agencyController,
                inputFormatters: [maskAgency],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Agency',
                  border: OutlineInputBorder(),
                ),
              ),
              sizeHeight,
              TextFormField(
                controller: accountController,
                inputFormatters: [maskAccount],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Account',
                  border: OutlineInputBorder(),
                ),
              ),
              sizeHeight,
              Material(
                color: Theme.of(context).primaryColor,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: InkWell(
                    onTap: () => addContactSubmit(context),
                    child: const SizedBox(
                      height: 56,
                      width: double.infinity,
                      child: Center(
                          child: Text(
                        'CREATE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      )),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
