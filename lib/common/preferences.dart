// Copyright 2020-2026 Tecdrop SRL. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file or at https://www.tecdrop.com/tapguid/license/.

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:simple_app_preferences/simple_app_preferences.dart';

import 'types.dart';

/// Stores the UUID version to use when generating UUIDs.
///
/// Added in version 4.0.0, and stored by name since version 4.1.0, so that adding a version
/// cannot change a stored choice.
var uuidVersion = AppPreferenceEx<UuidVersion, String>(
  defaultValue: .v4,
  key: 'uuidVersionName',
  valueLoader: (String name) => .values.asNameMap()[name] ?? .v4,
  valueSaver: (UuidVersion version) => version.name,
);

/// Stores whether to use uppercase letters in generated UUIDs.
///
/// Added in version 4.0.0.
var uppercaseDigits = AppPreference<bool>(
  defaultValue: false,
  key: 'uppercaseDigits',
);

/// Stores whether showing UUIDs in color is enabled.
///
/// Added in version 4.0.0.
var uuidColor = AppPreference<bool>(defaultValue: true, key: 'uuidColor');

/// Loads app settings from persistent storage.
Future<void> load() async {
  try {
    final preferences = await SharedPreferences.getInstance();
    uuidVersion.loadValue(preferences);
    uppercaseDigits.loadValue(preferences);
    uuidColor.loadValue(preferences);
  } on Exception catch (e) {
    // We can ignore errors here, as the default values will be used.
    if (kDebugMode) debugPrint('Error loading preferences: $e');
  }
}
