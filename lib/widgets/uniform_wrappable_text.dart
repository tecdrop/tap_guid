// Copyright 2014-2024 Tecdrop (https://www.tecdrop.com/)
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

/// A widget that displays wrappable text with uniform width characters.
class UniformWrappableText extends StatelessWidget {
  const UniformWrappableText(
    this.data, {
    super.key,
    this.style,
    this.characterWidth,
  });

  /// The text to display.
  final String data;

  /// The style to use for the text.
  final TextStyle? style;

  /// The width of each character in the text.
  final double? characterWidth;

  /// Returns the width of the widest character in the specified style.
  ///
  /// Uses the character 'W' to calculate the width, as it is usually the widest character.
  double _getWidestCharacterWidth() {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: 'W', style: style),
      textDirection: TextDirection.ltr,
    )..layout();

    return textPainter.size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: data
          .split('')
          .map(
            (String char) => SizedBox(
              width: characterWidth ?? _getWidestCharacterWidth(),
              child: Text(
                char,
                textAlign: TextAlign.center,
                style: style,
              ),
            ),
          )
          .toList(),
    );
  }
}
