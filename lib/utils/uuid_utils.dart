// Copyright 2014-2024 Tecdrop (https://www.tecdrop.com/)
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:ui';

import 'package:uuid/uuid.dart';

import '../common/types.dart';

/// Formats a UUID string according to the specified format.
String formatUuid(
  String uuid, {
  UuidFormat format = UuidFormat.standard,
  bool uppercase = false,
}) {
  final String formattedUuid = switch (format) {
    UuidFormat.standard => uuid,
    UuidFormat.digits => uuid.replaceAll(RegExp(r'-'), ''),
    UuidFormat.braces => '{$uuid}',
    UuidFormat.parentheses => '($uuid)',
    UuidFormat.urn => 'urn:uuid:$uuid',
    UuidFormat.base64 => base64.encode(Uuid.parse(uuid)),
    UuidFormat.base64url => base64Url.encode(Uuid.parse(uuid)),
  };

  // Uppercase the formatted UUID if required and if it is not base64 or base64url
  return uppercase && format != UuidFormat.base64 && format != UuidFormat.base64url
      ? formattedUuid.toUpperCase()
      : formattedUuid;
}

/// Creates a [Color] from a standard UUID string.
///
/// The color is based on the first 6 characters of the UUID.
Color getUuidColor(String uuid) {
  int hash = int.parse(uuid.substring(0, 6), radix: 16);
  return Color(hash & 0xFFFFFF | 0xFF000000);
}
