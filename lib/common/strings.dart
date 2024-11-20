// Copyright 2014-2024 Tecdrop (https://www.tecdrop.com/)
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file.

import 'types.dart';

// -----------------------------------------------------------------------------------------------
// App
// -----------------------------------------------------------------------------------------------

const String appName = 'TapGuid';

// -----------------------------------------------------------------------------------------------
// Home Screen
// -----------------------------------------------------------------------------------------------

const String homeScreenTitle = 'TapGuid';
const String newUuidTooltip = 'Generate a new UUID';
const String copyTooltip = 'Copy UUID to clipboard';
const String copiedSnackBar = 'UUID copied to clipboard.';
const String shareTooltip = 'Share UUID';
const String uniquenessSearchAction = 'Uniqueness search';
const String settingsAction = 'Settings';
const String rateAction = 'Rate app';
const String helpAction = 'Help';
const String goProAction = 'Go Pro';

const Map<UuidFormat, String> uuidFormatTabs = <UuidFormat, String>{
  UuidFormat.standard: 'Standard',
  UuidFormat.digits: 'Digits',
  UuidFormat.braces: 'Braces',
  UuidFormat.parentheses: 'Parentheses',
  UuidFormat.urn: 'URN',
  UuidFormat.base64: 'Base64',
  UuidFormat.base64url: 'Base64Url',
};
