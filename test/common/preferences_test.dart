// Copyright 2020-2026 Tecdrop SRL. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file or at https://www.tecdrop.com/tapguid/license/.

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tap_guid/common/preferences.dart' as prefs;
import 'package:tap_guid/common/types.dart';

void main() {
  test('The UUID version is saved by name', () async {
    SharedPreferences.setMockInitialValues({});
    await prefs.load();

    prefs.uuidVersion.value = .v7;
    await prefs.uuidVersion.saveValue();

    final stored = await SharedPreferences.getInstance();
    expect(stored.getString('uuidVersionName'), equals('v7'));
  });

  test('The UUID version is loaded by name', () async {
    SharedPreferences.setMockInitialValues({'uuidVersionName': 'v6'});
    await prefs.load();

    expect(prefs.uuidVersion.value, equals(UuidVersion.v6));
  });

  test('An unknown UUID version name falls back to v4', () async {
    SharedPreferences.setMockInitialValues({'uuidVersionName': 'v99'});
    await prefs.load();

    expect(prefs.uuidVersion.value, equals(UuidVersion.v4));
  });

  test('The UUID format is saved by name', () async {
    SharedPreferences.setMockInitialValues({});
    await prefs.load();

    prefs.uuidFormat.value = .braces;
    await prefs.uuidFormat.saveValue();

    final stored = await SharedPreferences.getInstance();
    expect(stored.getString('uuidFormatName'), equals('braces'));
  });

  test('The UUID format is loaded by name', () async {
    SharedPreferences.setMockInitialValues({'uuidFormatName': 'base64'});
    await prefs.load();

    expect(prefs.uuidFormat.value, equals(UuidFormat.base64));
  });

  test('An unknown UUID format name falls back to standard', () async {
    SharedPreferences.setMockInitialValues({'uuidFormatName': 'unknown'});
    await prefs.load();

    expect(prefs.uuidFormat.value, equals(UuidFormat.standard));
  });
}
