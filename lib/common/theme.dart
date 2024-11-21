// Copyright 2014-2024 Tecdrop (https://www.tecdrop.com/)
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

// import '../utils/color_utils.dart' as color_utils;

/// Returns the light or dark theme for the app.
ThemeData getAppTheme(Brightness brightness) {
  final Color accentColor = brightness == Brightness.dark ? Colors.white : Colors.black;
  final Color accentContrastColor = brightness == Brightness.dark ? Colors.black : Colors.white;

  final ColorScheme colorScheme =
      brightness == Brightness.dark ? const ColorScheme.dark() : const ColorScheme.light();

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme.copyWith(
      primary: accentColor,
      tertiary: brightness == Brightness.dark ? Color(0xFF4D4D4D) : Color(0xFFBFBFBF),
      primaryContainer: accentColor,
    ),
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: accentColor.withOpacity(0.5),
      labelColor: accentColor,
      indicatorColor: accentColor,
    ),
    dividerTheme: DividerThemeData(
      color: accentColor.withOpacity(0.125),
    ),
    chipTheme: ChipThemeData(
      showCheckmark: false,
      color: WidgetStateProperty.resolveWith((Set<WidgetState> states) =>
          states.contains(WidgetState.selected) ? accentColor : accentContrastColor),
      secondaryLabelStyle: TextStyle(color: accentContrastColor),
    ),
  );
}
