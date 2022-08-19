import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/list_sw.dart';
import '../../widgets/item_list_widget.dart';
import '../show/show_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.bars),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      body: ListView.separated(
        itemCount: listSW.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return ItemListWidget(
            character: listSW[index],
            iconButton: IconButton(
                key: Key(listSW[index].name),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ShowView(
                        character: listSW[index],
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.keyboard_arrow_right)),
          );
        },
      ),
    );
  }
}
