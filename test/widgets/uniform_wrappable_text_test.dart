// Copyright 2020-2025 Tecdrop SRL. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file or at https://www.tecdrop.com/tapguid/license/.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tap_guid/widgets/uniform_wrappable_text.dart';

void main() {
  testWidgets('UniformWrappableText renders with uniform character width', (
    WidgetTester tester,
  ) async {
    const testText = '123e4567-e89b-12d3';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Center(child: UniformWrappableText(testText))),
      ),
    );

    // Should render one Text widget per character
    expect(find.byType(Text), findsNWidgets(testText.length));

    // All SizedBox widgets should have the same width
    final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox)).toList();
    final firstWidth = sizedBoxes.first.width!;

    // All widths should be equal
    for (final box in sizedBoxes) {
      expect(box.width, equals(firstWidth));
    }
  });

  testWidgets('getWidestCharacterWidth calculates correct width', (WidgetTester tester) async {
    // Test with different font sizes
    const smallStyle = TextStyle(fontSize: 10.0);
    const largeStyle = TextStyle(fontSize: 20.0);

    final smallWidth = UniformWrappableText.getWidestCharacterWidth(smallStyle);
    final largeWidth = UniformWrappableText.getWidestCharacterWidth(largeStyle);

    // Width should be positive
    expect(smallWidth, isPositive);
    expect(largeWidth, isPositive);

    // Larger font size should produce larger width
    expect(largeWidth, greaterThan(smallWidth));

    // Check width is reasonable for the font size
    // In the test environment, we can only verify that the width is proportional to font size
    // and not zero, as actual character widths may not be accurately represented
    expect(largeWidth, greaterThanOrEqualTo(largeStyle.fontSize!));
  });
}
