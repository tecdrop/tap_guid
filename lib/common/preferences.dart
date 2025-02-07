// Copyright 2014-2025 Tecdrop (https://www.tecdrop.com/)
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file.

import 'package:shared_preferences/shared_preferences.dart';

import 'package:simple_app_preferences/simple_app_preferences.dart';
import 'package:tap_guid/common/types.dart';

/// Stores the UUID version to use when generating UUIDs.
///
/// Added in version 4.0.0.
AppPreferenceEx<UuidVersion, int> uuidVersion = AppPreferenceEx<UuidVersion, int>(
  defaultValue: UuidVersion.v4,
  key: 'uuidVersion',
  valueLoader: (int value) => UuidVersion.values[value],
  valueSaver: (UuidVersion version) => version.index,
);

/// Stores whether to use uppercase letters in generated UUIDs.
///
/// Added in version 4.0.0.
AppPreference<bool> uppercaseDigits = AppPreference<bool>(
  defaultValue: false,
  key: 'uppercaseDigits',
);

/// Stores whether showing UUIDs in color is enabled.
///
/// Added in version 4.0.0.
AppPreference<bool> uuidColor = AppPreference<bool>(
  defaultValue: true,
  key: 'uuidColor',
);

/// Loads app settings from persistent storage.
Future<void> load() async {
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    uppercaseDigits.loadValue(preferences);
    uuidColor.loadValue(preferences);
  } catch (e) {
    // We can ignore errors here, as the default values will be used.
    // ignore: avoid_print
    print('Error loading preferences: $e');
  }
}
