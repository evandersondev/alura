import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:flutter_tests/app/views/home/home_view.dart';

void main() {
  group('Home Test | ', () {
    testWidgets('Should find home title', (tester) async {
      await mockNetworkImagesFor(() => _createWidget(tester));

      final titleFinder = find.text('Home');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('Should find Luke Skywalker card', (tester) async {
      await mockNetworkImagesFor(() => _createWidget(tester));

      final titleFinder = find.text('Luke Skywalker');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('Should find Qui-Gon Jinn card and move to ShowView',
        (tester) async {
      await mockNetworkImagesFor(() => _createWidget(tester));

      final fisrtCard = find.byKey(const Key('Qui-Gon Jinn'));

      await tester.tap(fisrtCard);
      await tester.pumpAndSettle();

      final titleFinder = find.byKey(const Key('Qui-Gon'));
      await tester.pumpAndSettle();

      expect(titleFinder, findsOneWidget);
    });
  });
}

Future<void> _createWidget(WidgetTester tester) async {
  await tester.pumpWidget(
    const MaterialApp(
      home: HomeView(),
    ),
  );

  await tester.pump();
}
