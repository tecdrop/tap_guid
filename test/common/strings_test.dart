// Copyright 2020-2026 Tecdrop SRL. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file or at https://www.tecdrop.com/tapguid/license/.

import 'package:flutter_test/flutter_test.dart';

import 'package:tap_guid/common/strings.dart' as strings;
import 'package:tap_guid/common/types.dart';

void main() {
  test('Every UUID format has a tab label', () {
    expect(strings.uuidFormatTabs.keys, containsAll(UuidFormat.values));
  });
}
