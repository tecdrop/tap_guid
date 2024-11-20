// Copyright 2014-2024 Tecdrop (https://www.tecdrop.com/)
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
  final String hex = (color.value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase();
  return withHash ? '#$hex' : hex;
}
