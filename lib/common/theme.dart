// Copyright 2014-2024 Tecdrop (https://www.tecdrop.com/)
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

const Color appColor = Color(0xFF533B7C);

/// Returns the light or dark theme for the app.
ThemeData getAppTheme(Brightness brightness) {
  final Color backgroundColor = brightness == Brightness.dark ? Colors.black : Colors.white;
  final Color foregroundColor = brightness == Brightness.dark ? Colors.white : Colors.black;

  return ThemeData(
    brightness: brightness,
    useMaterial3: true,
    scaffoldBackgroundColor: backgroundColor,
    colorSchemeSeed: appColor,
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
    ),
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: foregroundColor.withOpacity(0.5),
      labelColor: foregroundColor,
      indicatorColor: foregroundColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
    ),
  );
}
