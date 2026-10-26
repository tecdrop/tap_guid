// Copyright 2020-2026 Tecdrop SRL. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file or at https://www.tecdrop.com/tapguid/license/.

import 'package:material_ui/material_ui.dart';

import 'common/preferences.dart' as prefs;
import 'common/strings.dart' as strings;
import 'common/theme.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load preferences before runApp, so the first UUID is generated with the stored settings
  await prefs.load();

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
