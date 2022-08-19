import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_tests/app/models/character_model.dart';

void main() {
  test('Should be create a character model', () {
    const character = CharacterModel(
      name: 'Lord Lucky',
      email: 'lucky@gmail.com',
      imageUrl: 'image.png',
      description: 'My dog',
    );

    expect(character.name, 'Lord Lucky');
  });

  test('Should error assert', () {
    expect(
        () => CharacterModel(
              name: '',
              email: '',
              imageUrl: '',
              description: '',
            ),
        throwsAssertionError);
  });
}
