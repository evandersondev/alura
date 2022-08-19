import 'package:flutter/material.dart';

import 'package:flutter_tests/app/models/character_model.dart';

class ItemListWidget extends StatelessWidget {
  const ItemListWidget({
    Key? key,
    required this.character,
    required this.iconButton,
  }) : super(key: key);

  final CharacterModel character;
  final IconButton iconButton;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        character.name,
        style: Theme.of(context).textTheme.headline6,
      ),
      subtitle: Text('E-mail: ${character.email}'),
      trailing: iconButton,
      leading: Column(
        children: [
          Hero(
            tag: character.name,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(character.imageUrl),
                  // onError: (exception, stackTrace) => {},
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
