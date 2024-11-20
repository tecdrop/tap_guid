// Copyright 2014-2024 Tecdrop (https://www.tecdrop.com/)
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'common/strings.dart' as strings;
import 'common/theme.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const TapGuidApp());
}

/// The main application widget, based on [MaterialApp].
class TapGuidApp extends StatelessWidget {
  const TapGuidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: strings.appName,
      theme: getAppTheme(Brightness.light),
      darkTheme: getAppTheme(Brightness.dark),
      home: const HomeScreen(),
    );
  }
}
