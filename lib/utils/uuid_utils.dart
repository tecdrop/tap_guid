// Copyright 2014-2024 Tecdrop (https://www.tecdrop.com/)
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:ui';

import 'package:uuid/uuid.dart';

import '../common/types.dart';

/// Formats a UUID string according to the specified format.
String formatUuid(String uuid, UuidFormat uuidFormat) {
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

/// Creates a [Color] from a standard UUID string.
///
/// The color is based on the first 6 characters of the UUID.
Color getUuidColor(String uuid) {
  int hash = int.parse(uuid.substring(0, 6), radix: 16);
  return Color(hash & 0xFFFFFF | 0xFF000000);
}
