// Copyright 2020-2025 Tecdrop SRL. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file or at https://www.tecdrop.com/tapguid/license/.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../common/types.dart';

/// Formats a UUID string according to the specified format.
String formatUuid(String uuid, {UuidFormat format = UuidFormat.standard, bool uppercase = false}) {
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
///
/// This function computes a raw color via a 32-bit FNV-1a hash, then averages its RGB channels with
/// a medium gray (#666666). The resulting color retains a unique hue from the UUID while the gray
/// mix tames extreme brightness and saturation, producing a muted, subdued, and neutral palette.
Color getUuidColor(String uuid) {
  final int hash = _fnvHash32(uuid);
  final Color generatedColor = Color(hash | 0xFF000000);

  // Simulate mixing by averaging the generated color with a medium gray (#666666)
  const Color gray = Color(0xFF666666);
  final int red = (((generatedColor.r * 255) + (gray.r * 255)) / 2).round();
  final int green = (((generatedColor.g * 255) + (gray.g * 255)) / 2).round();
  final int blue = (((generatedColor.b * 255) + (gray.b * 255)) / 2).round();

  return Color.fromARGB(255, red, green, blue);
}
