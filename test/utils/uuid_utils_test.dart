// Copyright 2020-2025 Tecdrop SRL. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file or at https://www.tecdrop.com/tapguid/license/.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:uuid/uuid.dart';

import 'package:tap_guid/common/types.dart';
import 'package:tap_guid/utils/uuid_utils.dart';

void main() {
  group('UUID formatting tests', () {
    const String testUuid = '123e4567-e89b-12d3-a456-426614174000';

    test('Standard format should return unchanged UUID', () {
      expect(formatUuid(testUuid, format: UuidFormat.standard), testUuid);
      expect(
        formatUuid(testUuid, format: UuidFormat.standard, uppercase: true),
        testUuid.toUpperCase(),
      );
    });

    test('Digits format should remove hyphens', () {
      expect(formatUuid(testUuid, format: UuidFormat.digits), '123e4567e89b12d3a456426614174000');
      expect(
        formatUuid(testUuid, format: UuidFormat.digits, uppercase: true),
        '123E4567E89B12D3A456426614174000',
      );
    });

    test('Braces format should add curly braces', () {
      expect(formatUuid(testUuid, format: UuidFormat.braces), '{$testUuid}');
      expect(
        formatUuid(testUuid, format: UuidFormat.braces, uppercase: true),
        '{${testUuid.toUpperCase()}}',
      );
    });

    test('Parentheses format should add round brackets', () {
      expect(formatUuid(testUuid, format: UuidFormat.parentheses), '($testUuid)');
      expect(
        formatUuid(testUuid, format: UuidFormat.parentheses, uppercase: true),
        '(${testUuid.toUpperCase()})',
      );
    });

    test('URN format should add urn:uuid: prefix', () {
      expect(formatUuid(testUuid, format: UuidFormat.urn), 'urn:uuid:$testUuid');
      expect(
        formatUuid(testUuid, format: UuidFormat.urn, uppercase: true),
        'urn:uuid:${testUuid.toUpperCase()}',
      );
    });

    test('Base64 formats should properly encode and ignore uppercase flag', () {
      final List<int> bytes = Uuid.parse(testUuid);
      final String expectedBase64 = base64.encode(bytes);
      final String expectedBase64Url = base64Url.encode(bytes);

      expect(formatUuid(testUuid, format: UuidFormat.base64), expectedBase64);
      expect(formatUuid(testUuid, format: UuidFormat.base64url), expectedBase64Url);

      // Uppercase should be ignored for base64 formats
      expect(formatUuid(testUuid, format: UuidFormat.base64, uppercase: true), expectedBase64);
      expect(
        formatUuid(testUuid, format: UuidFormat.base64url, uppercase: true),
        expectedBase64Url,
      );
    });

    test('Default format should be standard', () {
      expect(formatUuid(testUuid), testUuid);
    });

    test('Malformed UUIDs should throw appropriate exceptions in base64 formats', () {
      const String malformedUuid = 'not-a-valid-uuid';
      // Standard formatting shouldn't validate UUID format
      expect(formatUuid(malformedUuid, format: UuidFormat.standard), malformedUuid);

      // Base64 formats should throw because Uuid.parse will fail
      expect(() => formatUuid(malformedUuid, format: UuidFormat.base64), throwsException);
      expect(() => formatUuid(malformedUuid, format: UuidFormat.base64url), throwsException);
    });
  });

  group('UUID color tests', () {
    test('getUuidColor returns consistent colors for the same UUID', () {
      const String uuid1 = '123e4567-e89b-12d3-a456-426614174000';

      // Same UUID should produce the same color
      final Color color1a = getUuidColor(uuid1);
      final Color color1b = getUuidColor(uuid1);
      expect(color1a, equals(color1b));
    });

    test('getUuidColor returns different colors for different UUIDs', () {
      const String uuid1 = '123e4567-e89b-12d3-a456-426614174000';
      const String uuid2 = '00112233-4455-6677-8899-aabbccddeeff';

      // Different UUIDs should produce different colors
      final Color color1 = getUuidColor(uuid1);
      final Color color2 = getUuidColor(uuid2);
      expect(color1, isNot(equals(color2)));
    });

    test('getUuidColor always returns colors with alpha set to 1.0 (fully opaque)', () {
      const String uuid1 = '123e4567-e89b-12d3-a456-426614174000';
      const String uuid2 = '00112233-4455-6677-8899-aabbccddeeff';

      // Colors should always have alpha = 1.0 (fully opaque)
      expect(getUuidColor(uuid1).a, equals(1.0));
      expect(getUuidColor(uuid2).a, equals(1.0));
    });

    test('FNV hash function produces expected output pattern', () {
      // Base UUID
      const String baseUuid = '123e4567-e89b-12d3-a456-426614174000';
      final Color baseColor = getUuidColor(baseUuid);

      // Change just one character
      const String singleCharChange = '123e4567-e89b-12d3-a456-426614174001';
      final Color singleCharColor = getUuidColor(singleCharChange);

      // Swap two characters (first and last digits)
      const String swappedChars = '023e4567-e89b-12d3-a456-426614174001';
      final Color swappedColor = getUuidColor(swappedChars);

      // All should produce different colors
      expect(baseColor, isNot(equals(singleCharColor)));
      expect(baseColor, isNot(equals(swappedColor)));
      expect(singleCharColor, isNot(equals(swappedColor)));

      // Same UUID should always produce same color
      expect(getUuidColor(baseUuid), equals(baseColor));
    });
  });
}
