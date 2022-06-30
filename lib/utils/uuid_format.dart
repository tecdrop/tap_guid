// Copyright 2022 Aurelitec. All rights reserved.
// Use of this source code is governed by a user license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:uuid/uuid.dart';

enum UuidFormat { standard, digits, braces, parentheses, urn, base64, base64url }

String formatUuid(String uuid, int formatIndex) {
  UuidFormat uuidFormat = UuidFormat.values[formatIndex];
  switch (uuidFormat) {
    case UuidFormat.standard:
      return uuid;
    case UuidFormat.digits:
      return uuid.replaceAll(RegExp(r'-'), '');
    case UuidFormat.braces:
      return '{$uuid}';
    case UuidFormat.parentheses:
      return '($uuid)';
    case UuidFormat.urn:
      return 'urn:uuid:$uuid';
    case UuidFormat.base64:
      return base64.encode(Uuid.parse(uuid));
    case UuidFormat.base64url:
      return base64Url.encode(Uuid.parse(uuid));
  }
}
