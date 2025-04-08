// Copyright 2020-2025 Tecdrop SRL. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file or at https://www.tecdrop.com/tapguid/license/.

import 'package:flutter/material.dart';

import '../common/preferences.dart' as prefs;
import '../common/strings.dart' as strings;
import '../common/types.dart';

/// The settings screen of the app.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = MediaQuery.sizeOf(context).width > 600.0;

    final Widget vSpacer =
        isLargeScreen ? const SizedBox(height: 16.0) : const SizedBox(height: 8.0);

    return Scaffold(
      appBar: AppBar(title: const Text(strings.settingsScreenTitle)),
      body: Center(
        // Limit the width of the settings content for better readability on large screens
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800.0),
          child: ListView(
            children: <Widget>[
              vSpacer,

              // The UUID version setting
              ListTile(
                title: Text(strings.uuidVersionSetting),
                subtitle: Wrap(
                  spacing: isLargeScreen ? 16.0 : 8.0,
                  children:
                      UuidVersion.values.map((UuidVersion version) {
                        return ChoiceChip(
                          label: Text(strings.uuidVersionNames[version]!),
                          selected: prefs.uuidVersion.value == version,
                          onSelected: (bool selected) {
                            if (selected) {
                              setState(() => prefs.uuidVersion.value = version);
                            }
                          },
                        );
                      }).toList(),
                ),
              ),

              vSpacer,

              // The uppercase digits setting
              SwitchListTile(
                title: const Text(strings.uppercaseDigitsSetting),
                value: prefs.uppercaseDigits.value,
                onChanged: (bool value) {
                  setState(() => prefs.uppercaseDigits.value = value);
                },
              ),

              vSpacer,

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
        ),
      ),
    );
  }
}
