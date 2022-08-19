import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:localstorage/localstorage.dart';

import '../models/character_model.dart';

class FavoritesController extends ChangeNotifier {
  FavoritesController() {
    init();
  }

  final storage = LocalStorage('favoriteSW.json');
  List<CharacterModel> favorites = [];

  Future<void> addFavorite(CharacterModel character) async {
    await storage.ready;

    final characters = storage.getItem('favorites');
    if (characters != null) {
      if (favorites.contains(character)) {
        favorites.removeWhere((e) => e == character);

        storage.setItem('favorites', jsonEncode(favorites));
        notifyListeners();

        return;
      }
    }

    favorites.add(character);
    notifyListeners();
    storage.setItem('favorites', jsonEncode(favorites));
  }

  Future<void> init() async {
    await storage.ready;

    final characters = storage.getItem('favorites');
    final listFavorites =
        characters != null ? jsonDecode(characters) as List : [];

    final favoritesList =
        listFavorites.map((e) => CharacterModel.fromJson(e)).toList();

    favorites = favoritesList;
    notifyListeners();
  }
}
