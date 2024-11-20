// Copyright 2014-2024 Tecdrop (https://www.tecdrop.com/)
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../common/app_preferences.dart' as prefs;
import '../common/strings.dart' as strings;

/// The settings screen of the app.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(strings.settingsScreenTitle),
      ),
      body: ListView(
        children: <Widget>[
          // The uppercase digits setting
          SwitchListTile(
            title: const Text(strings.uppercaseDigitsSetting),
            value: prefs.uppercaseDigits.value,
            onChanged: (bool value) {
              setState(() => prefs.uppercaseDigits.value = value);
            },
          ),

          // The UUID color setting
          SwitchListTile(
            title: const Text(strings.uuidColorSetting),
            value: prefs.uuidColor.value,
            onChanged: (bool value) {
              setState(() => prefs.uuidColor.value = value);
            },
          ),
        ],
      ),
    );
  }
}
