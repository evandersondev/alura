import 'package:flutter/material.dart';

import '../models/pages_model.dart';
import '../pages/contact/contact_list_page.dart';
import '../pages/dashboard/dashboard_page.dart';
import '../pages/name/name_page.dart';
import '../pages/transaction/transaction_list_page.dart';

final pages = [
  PagesModel(
    page: DashboardContainer(),
    icon: Icons.roofing_rounded,
    title: 'Dashboard',
  ),
  PagesModel(
    page: const ContactListContainer(),
    icon: Icons.description_outlined,
    title: 'Contacts',
  ),
  PagesModel(
    page: const TransactionListPage(),
    icon: Icons.monetization_on_outlined,
    title: 'Transactions',
  ),
  PagesModel(
    page: NamePage(),
    icon: Icons.person_outline_rounded,
    title: 'Transactions',
  ),
];
