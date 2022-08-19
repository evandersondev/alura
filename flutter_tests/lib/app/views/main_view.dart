import 'package:flutter/material.dart';

import 'package:flutter_tests/app/views/favorite/favorite_view.dart';

import '../widgets/sidebar_widget.dart';

import 'home/home_view.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final pageController = PageController();
  final listPage = [
    const HomeView(),
    FavoriteView(),
  ];
  int pageIndex = 0;

  void selectPage(int index) {
    pageController.jumpToPage(index);

    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidebarWidget(selectPage: selectPage),
      body: PageView.builder(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) => selectPage(value),
        itemBuilder: (context, index) {
          return listPage[index];
        },
      ),
    );
  }
}
