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

/// 32-bit FNV-1a hash function.
int _fnvHash32(String input) {
  int hash = 0x811c9dc5;
  for (final int byte in utf8.encode(input)) {
    hash = ((hash ^ byte) * 0x1000193) & 0xFFFFFFFF;
  }
  return hash;
}

/// Creates a [Color] from a standard UUID string using a fast hash function.
Color getUuidColor(String uuid) => Color(_fnvHash32(uuid) | 0xFF000000);
