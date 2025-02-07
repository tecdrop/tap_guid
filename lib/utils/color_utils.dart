// Copyright 2014-2025 Tecdrop (https://www.tecdrop.com/)
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

/// Returns the black or white contrast color of the given [Color].
Color contrastColor(Color color) {
  switch (ThemeData.estimateBrightnessForColor(color)) {
    case Brightness.light:
      return Colors.black;
    case Brightness.dark:
      return Colors.white;
  }
}

/// Returns the hexadecimal string representation of the given [Color].
String toHexString(Color color, {bool withHash = true}) {
  // Converts a normalized color channel (0.0 to 1.0) to a two-digit hex string.
  String cToHex(double c) => ((c * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0');
  final String hex = '${cToHex(color.r)}${cToHex(color.g)}${cToHex(color.b)}'.toUpperCase();
  return withHash ? '#$hex' : hex;
}
