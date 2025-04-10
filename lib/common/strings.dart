// Copyright 2020-2025 Tecdrop SRL. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file or at https://www.tecdrop.com/tapguid/license/.

import 'types.dart';

// -----------------------------------------------------------------------------
// App
// -----------------------------------------------------------------------------

const String appName = 'TapGuid';

// -----------------------------------------------------------------------------
// Common
// -----------------------------------------------------------------------------

const String uuid = 'UUID';

// -----------------------------------------------------------------------------
// Home Screen
// -----------------------------------------------------------------------------

const String homeScreenTitleShort = 'TapGuid';
const String homeScreenTitle = 'TapGuid - UUID Generator';
const String newUuidTooltip = 'Generate a new UUID';

const String copyTooltip = 'Copy UUID to clipboard';
String copiedSnack(String value) => '$value copied to clipboard';
String copiedErrorSnack(String value) => 'Failed to copy $value to clipboard';

const String copyColorAction = 'Copy color code';
const String shareTooltip = 'Share UUID';
const String uniquenessSearchAction = 'Uniqueness search';
const String settingsAction = 'Settings';
const String helpAction = 'Help & support';
const String openSourceAction = 'Star on GitHub';
const String rateAction = 'Rate app';
const String proAppsAction = 'Try our Pro apps';

const Map<UuidFormat, String> uuidFormatTabs = <UuidFormat, String>{
  UuidFormat.standard: 'Standard',
  UuidFormat.digits: 'Digits',
  UuidFormat.braces: 'Braces',
  UuidFormat.parentheses: 'Parentheses',
  UuidFormat.urn: 'URN',
  UuidFormat.base64: 'Base64',
  UuidFormat.base64url: 'Base64Url',
};

const String shareSubject = 'UUID from TapGuid';

// -----------------------------------------------------------------------------------------------
// Drawer items
// -----------------------------------------------------------------------------------------------

const String supportOurAppsDrawerItem = 'Support our free apps: try our Pro apps';
const String pbwpDrawerItem = 'Pitch Black Wallpaper Pro';
const String rcwpDrawerItem = 'RGB Color Wallpaper Pro';

const String guidGeneratorDrawerItem = 'Generate GUIDs/UUIDs';
const String settingsDrawerItem = 'Settings';

const String helpDrawerItem = 'Help & Support';
const String openSourceDrawerItem = 'Star on GitHub';
const String openSourceDrawerItemSubtitle = 'Yes, it\'s open source!';
const String rateAppDrawerItem = 'Rate App';

// -----------------------------------------------------------------------------
// Settings Screen
// -----------------------------------------------------------------------------

const String settingsScreenTitle = 'Settings';

const String uuidVersionSetting = 'UUID version';
const Map<UuidVersion, String> uuidVersionNames = <UuidVersion, String>{
  UuidVersion.v1: 'v1',
  UuidVersion.v4: 'v4',
  UuidVersion.v6: 'v6',
  UuidVersion.v7: 'v7',
  UuidVersion.v8: 'v8',
};
const String uppercaseDigitsSetting = 'Use uppercase letters in UUIDs';
const String uuidColorSetting = 'Computed colors for each UUID';
