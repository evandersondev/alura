import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/app_size.dart';
import '../themes/app_colors.dart';

class SidebarWidget extends StatelessWidget {
  const SidebarWidget({
    Key? key,
    required this.selectPage,
  }) : super(key: key);

  final Function(int index) selectPage;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryDark,
      child: Padding(
        padding: const EdgeInsets.all(AppSize.padding),
        child: Column(children: [
          DrawerHeader(
            padding: const EdgeInsets.only(bottom: AppSize.padding),
            child: Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                      'https://www.elhombre.com.br/wp-content/uploads/2022/05/star-wars-celebration-anahiem-2022-tickets-836122_TALL.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Home',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    )),
            trailing: const FaIcon(
              FontAwesomeIcons.house,
              color: AppColors.white,
            ),
            onTap: () {
              selectPage(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Favorites',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    )),
            trailing: const FaIcon(
              FontAwesomeIcons.solidHeart,
              color: AppColors.white,
            ),
            onTap: () {
              selectPage(1);
              Navigator.pop(context);
            },
          ),
          const Spacer(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            trailing: const FaIcon(
              FontAwesomeIcons.arrowRightFromBracket,
              color: AppColors.white,
            ),
            title: Text('Lougout',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    )),
            onTap: () {},
          )
        ]),
      ),
    );
  }
}
