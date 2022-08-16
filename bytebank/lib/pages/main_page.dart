import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/pages.dart';
import '../models/name_model.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) => NameCubit('Asafe')),
      child: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
    this.pageIndex = 0,
  }) : super(key: key);

  final int pageIndex;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _pageController = PageController();
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();

    _pageIndex = widget.pageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: appNavigation(),
      body: PageView.builder(
        itemCount: pages.length,
        itemBuilder: (context, index) => pages[_pageIndex].page,
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
    );
  }

  BottomNavigationBar appNavigation() {
    return BottomNavigationBar(
      currentIndex: _pageIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 26,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      elevation: 4,
      items: pages.map((page) {
        return BottomNavigationBarItem(
          icon: Icon(page.icon),
          label: page.title,
        );
      }).toList(),
      onTap: (index) {
        setState(() {
          _pageIndex = index;
          _pageController.jumpToPage(index);
        });
      },
    );
  }
}
