import 'package:bytebank/models/contact_model.dart';
import 'package:flutter/material.dart';

class ContatcItemWidget extends StatelessWidget {
  const ContatcItemWidget({
    Key? key,
    required this.contact,
  }) : super(key: key);

  final ContactModel contact;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      visualDensity: VisualDensity.comfortable,
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        child: Text(
          contact.name.split('').first,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      title: Text(
        contact.name.toUpperCase(),
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Agência: ${contact.agency}, '),
          Text('Conta: ${contact.account}'),
        ],
      ),
    );
  }
}
