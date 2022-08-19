import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_tests/app/themes/app_colors.dart';

import '../../controllers/favorites_controllers.dart';
import '../../widgets/item_list_widget.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = FavoritesController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.bars),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      body: AnimatedBuilder(
          animation: controller,
          builder: (context, snapshot) {
            final characters = controller.favorites;

            return characters.isNotEmpty
                ? RefreshIndicator(
                    onRefresh: controller.init,
                    child: ListView.separated(
                      itemCount: characters.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        return ItemListWidget(
                          character: characters[index],
                          iconButton: IconButton(
                            onPressed: () async {
                              await controller.addFavorite(characters[index]);
                              await controller.init();
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.solidHeart,
                              color: characters.contains(characters[index])
                                  ? AppColors.danger
                                  : AppColors.gray,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: Text(
                      'Favorites is empty!',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                    ),
                  );
          }),
    );
  }
}
