// Copyright 2022 Aurelitec. All rights reserved.
// Use of this source code is governed by a user license that can be
// found in the LICENSE file.

// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import '../utils/uuid_format.dart';

/// User interface static string constants.
class UIStrings {
  // -----------------------------------------------------------------------------------------------
  // App
  // -----------------------------------------------------------------------------------------------

  static const String appName = 'UniqueGen';

  // -----------------------------------------------------------------------------------------------
  // Home Screen
  // -----------------------------------------------------------------------------------------------

  static const String home_screenTitle = appName;
  static const String home_fabTooltip = 'Generate a new UUID';
  static const String home_copyTooltip = 'Copy UUID to clipboard';
  static const String home_shareAction = 'Share...';

  // static const home_formatTabs = ['Standard', 'Digits', 'Braces', 'Parentheses', 'URN', 'Base64'];

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
