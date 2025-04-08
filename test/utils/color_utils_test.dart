// Copyright 2020-2025 Tecdrop SRL. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file or at https://www.tecdrop.com/tapguid/license/.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tap_guid/utils/color_utils.dart';

void main() {
  test('contrastColor returns black for light colors and white for dark colors', () {
    // Light colors should return black contrast
    expect(contrastColor(Colors.white), equals(Colors.black));
    expect(contrastColor(Colors.yellow), equals(Colors.black));

    // Dark colors should return white contrast
    expect(contrastColor(Colors.black), equals(Colors.white));
    expect(contrastColor(Colors.blue.shade900), equals(Colors.white));
  });

  test('toHexString formats color correctly', () {
    expect(toHexString(const Color(0xFFFF0000)), equals('#FF0000'));
    expect(toHexString(const Color(0xFF00FF00), withHash: false), equals('00FF00'));
  });
}
