// Copyright 2014-2024 Tecdrop (https://www.tecdrop.com/)
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

/// Returns the light or dark theme for the app.
ThemeData getAppTheme(Brightness brightness) {
  // final Color backgroundColor = brightness == Brightness.dark ? Colors.black : Colors.white;
  final Color foregroundColor = brightness == Brightness.dark ? Colors.white : Colors.black;

  final ColorScheme colorScheme =
      brightness == Brightness.dark ? const ColorScheme.dark() : const ColorScheme.light();

  return ThemeData(
    // brightness: brightness,
    useMaterial3: true,
    // scaffoldBackgroundColor: backgroundColor,
    // colorSchemeSeed: appColor,
    // colorSchemeSeed: Colors.white,
    colorScheme: colorScheme.copyWith(
      primary: foregroundColor,
      tertiary: brightness == Brightness.dark ? Color(0xFF4D4D4D) : Color(0xFFBFBFBF),
      primaryContainer: foregroundColor,
      // primaryContainer: Colors.black,
    ),
    // appBarTheme: AppBarTheme(
    //   backgroundColor: backgroundColor,
    //   foregroundColor: foregroundColor,
    // ),
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: foregroundColor.withOpacity(0.5),
      labelColor: foregroundColor,
      indicatorColor: foregroundColor,
    ),
    dividerTheme: DividerThemeData(
      color: foregroundColor.withOpacity(0.125),
    ),
    // popupMenuTheme: PopupMenuThemeData(
    //   color: backgroundColor,
    //   // textStyle: TextStyle(color: foregroundColor),
    // ),
    // floatingActionButtonTheme: FloatingActionButtonThemeData(
    //   backgroundColor: Colors.black,
    //   foregroundColor: Colors.white,
    // ),
  );
}
