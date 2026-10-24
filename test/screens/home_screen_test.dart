// Copyright 2020-2026 Tecdrop SRL. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file or at https://www.tecdrop.com/tapguid/license/.

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:tap_guid/common/strings.dart' as strings;
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
    final initialText =
        (tester.widget(find.byType(UniformWrappableText)) as UniformWrappableText).data;

    // Switch to the Braces tab
    await tester.tap(find.text('Braces'));
    await tester.pumpAndSettle();

    // Get the new UUID text
    final bracesText =
        (tester.widget(find.byType(UniformWrappableText)) as UniformWrappableText).data;

    // The text should have changed and now contain braces
    expect(bracesText, isNot(equals(initialText)));
    expect(bracesText.startsWith('{'), isTrue);
    expect(bracesText.endsWith('}'), isTrue);
  });

  testWidgets('FAB generates a new UUID', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // Get the initial UUID text
    final initialText =
        (tester.widget(find.byType(UniformWrappableText)) as UniformWrappableText).data;

    // Tap the FAB to generate a new UUID
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    // Get the new UUID text
    final newText = (tester.widget(find.byType(UniformWrappableText)) as UniformWrappableText).data;

    // The UUID should have changed
    expect(newText, isNot(equals(initialText)));
  });

  testWidgets('Tapping the UUID copies it to the clipboard', (WidgetTester tester) async {
    // Capture what the app writes to the clipboard
    String? copiedText;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, (
      MethodCall call,
    ) async {
      if (call.method == 'Clipboard.setData') {
        copiedText = (call.arguments as Map<Object?, Object?>)['text'] as String?;
      }
      return null;
    });
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );

    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
    final uuid = (tester.widget(find.byType(UniformWrappableText)) as UniformWrappableText).data;

    await tester.tap(find.byType(UniformWrappableText));
    await tester.pump();

    expect(copiedText, equals(uuid));
    expect(find.text(strings.copiedSnack(strings.uuid)), findsOneWidget);
  });

  testWidgets('Screen readers can copy the UUID with a hint', (WidgetTester tester) async {
    final semantics = tester.ensureSemantics();

    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
    final uuid = (tester.widget(find.byType(UniformWrappableText)) as UniformWrappableText).data;

    // The UUID is one node that can be tapped, with the copy hint
    expect(
      tester.getSemantics(find.bySemanticsLabel(uuid)),
      matchesSemantics(label: uuid, hasTapAction: true, onTapHint: strings.copyTooltip),
    );

    semantics.dispose();
  });
}
