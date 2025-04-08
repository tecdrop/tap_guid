// Copyright 2020-2025 Tecdrop SRL. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file or at https://www.tecdrop.com/tapguid/license/.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tap_guid/screens/home_screen.dart';
import 'package:tap_guid/widgets/uniform_wrappable_text.dart';

void main() {
  testWidgets('HomeScreen displays a UUID on launch', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // A UUID should be displayed in some format
    expect(find.byType(UniformWrappableText), findsOneWidget);
  });

  testWidgets('Tab switching changes the UUID format', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // Get the initial UUID text
    final String initialText =
        (tester.widget(find.byType(UniformWrappableText)) as UniformWrappableText).data;

    // Switch to the Braces tab
    await tester.tap(find.text('Braces'));
    await tester.pumpAndSettle();

    // Get the new UUID text
    final String bracesText =
        (tester.widget(find.byType(UniformWrappableText)) as UniformWrappableText).data;

    // The text should have changed and now contain braces
    expect(bracesText, isNot(equals(initialText)));
    expect(bracesText.startsWith('{'), isTrue);
    expect(bracesText.endsWith('}'), isTrue);
  });

  testWidgets('FAB generates a new UUID', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // Get the initial UUID text
    final String initialText =
        (tester.widget(find.byType(UniformWrappableText)) as UniformWrappableText).data;

    // Tap the FAB to generate a new UUID
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    // Get the new UUID text
    final String newText =
        (tester.widget(find.byType(UniformWrappableText)) as UniformWrappableText).data;

    // The UUID should have changed
    expect(newText, isNot(equals(initialText)));
  });
}
