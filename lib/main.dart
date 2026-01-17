// Copyright 2020-2025 Tecdrop SRL. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file or at https://www.tecdrop.com/tapguid/license/.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'common/preferences.dart' as prefs;
import 'common/strings.dart' as strings;
import 'common/theme.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load preferences with timeout - use defaults if it takes too long
  await prefs.load().timeout(
    const Duration(seconds: 1),
    onTimeout: () {
      if (kDebugMode) debugPrint('Preferences load timed out, using defaults');
    },
  );

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
      theme: getAppTheme(.light),
      darkTheme: getAppTheme(.dark),
      home: const HomeScreen(),
    );
  }
}
