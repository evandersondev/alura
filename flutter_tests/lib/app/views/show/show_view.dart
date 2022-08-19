import 'package:flutter/material.dart';

import 'package:flutter_tests/app/constants/app_size.dart';
import 'package:flutter_tests/app/models/character_model.dart';
import 'package:flutter_tests/app/themes/app_colors.dart';

import '../../controllers/favorites_controllers.dart';

class ShowView extends StatelessWidget {
  ShowView({
    Key? key,
    required this.character,
  }) : super(key: key);

  final CharacterModel character;
  final controller = FavoritesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          character.name.split(' ')[0],
          key: Key(
            character.name.split(' ')[0],
          ),
        ),
      ),
      floatingActionButton: AnimatedBuilder(
          animation: Listenable.merge([controller]),
          builder: (context, child) {
            return FloatingActionButton(
              key: const Key('favoriteButton'),
              onPressed: () async {
                await controller.addFavorite(character);
              },
              backgroundColor: controller.favorites.contains(character)
                  ? AppColors.danger
                  : AppColors.gray,
              child: const Icon(
                Icons.favorite,
                color: AppColors.white,
              ),
            );
          }),
      body: Padding(
        padding: const EdgeInsets.only(bottom: AppSize.margin * 2),
        child: ListView(children: [
          Hero(
            tag: character.name,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(character.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSize.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  character.name,
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  character.email,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: AppColors.black.withOpacity(0.5),
                      ),
                ),
                const SizedBox(height: AppSize.padding),
                Text(
                  character.description,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        height: 1.5,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
