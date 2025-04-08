// Copyright 2020-2025 Tecdrop SRL. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file or at https://www.tecdrop.com/tapguid/license/.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:tap_guid/common/preferences.dart' as prefs;
import 'package:tap_guid/common/types.dart';
import 'package:tap_guid/screens/settings_screen.dart';

void main() {
  setUp(() async {
    // Set up SharedPreferences for testing
    SharedPreferences.setMockInitialValues({});
    await prefs.load();
  });

  testWidgets('Settings screen shows current preferences', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));

    // Check that the UUID version choice chips are displayed
    expect(find.text('v1'), findsOneWidget);
    expect(find.text('v4'), findsOneWidget);

    // Check that the uppercase digits switch is displayed
    expect(find.text('Use uppercase letters in UUIDs'), findsOneWidget);

    // Check that the UUID color switch is displayed
    expect(find.text('Computed colors for each UUID'), findsOneWidget);
  });

  testWidgets('Changing UUID version updates preference', (WidgetTester tester) async {
    // Start with v4 selected
    prefs.uuidVersion.value = UuidVersion.v4;

    await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));

    // Find and tap the v1 version chip
    await tester.tap(find.text('v1'));
    await tester.pump();

    // The preference should be updated
    expect(prefs.uuidVersion.value, equals(UuidVersion.v1));
  });

  testWidgets('Toggling uppercase digits updates preference', (WidgetTester tester) async {
    // Start with uppercase digits disabled
    prefs.uppercaseDigits.value = false;

    await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));

    // Find and tap the uppercase digits switch
    await tester.tap(find.byType(Switch).first);
    await tester.pump();

    // The preference should be updated
    expect(prefs.uppercaseDigits.value, equals(true));
  });
}
