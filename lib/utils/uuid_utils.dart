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

/// Calculates a fast hash of a string using the FNV-1a algorithm with a 64-bit prime.
int _fastHash(String string) {
  var hash = 0xcbf29ce484222325;

  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }

  return hash;
}

/// Creates a [Color] from a standard UUID string using a fast hash function.
Color getUuidColor(String uuid) => Color(_fastHash(uuid) | 0xFF000000);
