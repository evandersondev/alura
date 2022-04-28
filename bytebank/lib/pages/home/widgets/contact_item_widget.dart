import 'package:bytebank/models/contact_model.dart';
import 'package:bytebank/pages/transaction/add_transaction_page.dart';
import 'package:bytebank/themes/colors_app.dart';
import 'package:bytebank/themes/constants.dart';
import 'package:flutter/material.dart';

class ContatcItemWidget extends StatelessWidget {
  const ContatcItemWidget({
    Key? key,
    required this.contact,
  }) : super(key: key);

  final ContactModel contact;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: paddingSize),
      child: ListTile(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AddTransactionPage(
              contact: contact,
            ),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        visualDensity: VisualDensity.comfortable,
        leading: CircleAvatar(
          backgroundColor: darkColor,
          child: Text(
            contact.name.split('').first,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: darkColor,
        ),
        title: Text(
          contact.name.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Row(
          children: [
            Text('Agência: ${contact.agency}, '),
            Text('Conta: ${contact.account}'),
          ],
        ),
      ),
    );
  }
}
