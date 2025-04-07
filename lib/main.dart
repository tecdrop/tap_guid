// Copyright 2020-2025 Tecdrop SRL. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file or at https://www.tecdrop.com/tapguid/license/.

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
