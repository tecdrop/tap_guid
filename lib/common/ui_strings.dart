// Copyright 2014-2024 Tecdrop (https://www.tecdrop.com/)
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file.

// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import '../utils/uuid_format.dart';

/// User interface static string constants.
class UIStrings {
  // -----------------------------------------------------------------------------------------------
  // App
  // -----------------------------------------------------------------------------------------------

  static const String appName = 'TapGuid';

  // -----------------------------------------------------------------------------------------------
  // Home Screen
  // -----------------------------------------------------------------------------------------------

  static const String home_screenTitle = 'Generate UUIDs';
  static const String home_fabTooltip = 'Generate a new UUID';
  static const String home_copyTooltip = 'Copy UUID to clipboard';
  static const String home_copiedSnackBar = 'UUID copied to clipboard.';
  static const String home_shareAction = 'Share...';
  static const String home_uniquenessSearchAction = 'Uniqueness search';
  static const String home_settingsAction = 'Settings';
  static const String home_rateAction = 'Rate app';
  static const String home_helpAction = 'Help';
  static const String home_goProAction = 'Go Pro';

  static const Map<UuidFormat, String> home_formatTabs = <UuidFormat, String>{
    UuidFormat.standard: 'Standard',
    UuidFormat.digits: 'Digits',
    UuidFormat.braces: 'Braces',
    UuidFormat.parentheses: 'Parentheses',
    UuidFormat.urn: 'URN',
    UuidFormat.base64: 'Base64',
    UuidFormat.base64url: 'Base64Url',
  };
}
