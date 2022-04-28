import 'package:flutter/material.dart';

import '../../../themes/colors_app.dart';
import '../../../themes/constants.dart';
import '../../contact/add_contact_page.dart';
import '../../transaction/transaction_list_page.dart';
import 'square_buttom_widget.dart';

class FloatingButtonsWidget extends StatelessWidget {
  const FloatingButtonsWidget({
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
          iconColor: whiteColor,
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
