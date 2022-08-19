import 'dart:convert';

import 'package:equatable/equatable.dart';

class CharacterModel extends Equatable {
  final String name;
  final String email;
  final String imageUrl;
  final String description;

  const CharacterModel({
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.description,
  })  : assert(name != ''),
        assert(email != ''),
        assert(imageUrl != ''),
        assert(description != '');

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'imageUrl': imageUrl});
    result.addAll({'description': description});

    return result;
  }

  factory CharacterModel.fromMap(Map<String, dynamic> map) {
    return CharacterModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CharacterModel.fromJson(String source) =>
      CharacterModel.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
        name,
        email,
        imageUrl,
        description,
      ];
}
