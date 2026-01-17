// Copyright 2020-2026 Tecdrop SRL. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file or at https://www.tecdrop.com/tapguid/license/.

import 'types.dart';

// -----------------------------------------------------------------------------
// App
// -----------------------------------------------------------------------------

const appName = 'TapGuid';

// -----------------------------------------------------------------------------
// Common
// -----------------------------------------------------------------------------

const uuid = 'UUID';

// -----------------------------------------------------------------------------
// Home Screen
// -----------------------------------------------------------------------------

const homeScreenTitleShort = 'TapGuid';
const homeScreenTitle = 'TapGuid - UUID Generator';
const newUuidTooltip = 'Generate a new UUID';

const copyTooltip = 'Copy UUID to clipboard';
String copiedSnack(String value) => '$value copied to clipboard';
String copiedErrorSnack(String value) => 'Failed to copy $value to clipboard';

const copyColorAction = 'Copy color code';
const shareTooltip = 'Share UUID';
const uniquenessSearchAction = 'Uniqueness search';
const settingsAction = 'Settings';
const helpAction = 'Help & support';
const openSourceAction = 'Star on GitHub';
const rateAction = 'Rate app';
const proAppsAction = 'Try our Pro apps';

const uuidFormatTabs = <UuidFormat, String>{
  .standard: 'Standard',
  .digits: 'Digits',
  .braces: 'Braces',
  .parentheses: 'Parentheses',
  .urn: 'URN',
  .base64: 'Base64',
  .base64url: 'Base64Url',
};

const shareSubject = 'UUID from TapGuid';

// -----------------------------------------------------------------------------------------------
// Drawer items
// -----------------------------------------------------------------------------------------------

const supportOurAppsDrawerItem = 'Support our free apps: try our Pro apps';
const pbwpDrawerItem = 'Pitch Black Wallpaper Pro';
const rcwpDrawerItem = 'RGB Color Wallpaper Pro';

const guidGeneratorDrawerItem = 'Generate GUIDs/UUIDs';
const settingsDrawerItem = 'Settings';

const helpDrawerItem = 'Help & Support';
const openSourceDrawerItem = 'Star on GitHub';
const openSourceDrawerItemSubtitle = 'Yes, it\'s open source!';
const rateAppDrawerItem = 'Rate App';

// -----------------------------------------------------------------------------
// Settings Screen
// -----------------------------------------------------------------------------

const settingsScreenTitle = 'Settings';

const uuidVersionSetting = 'UUID version';
const uuidVersionNames = <UuidVersion, String>{
  .v1: 'v1',
  .v4: 'v4',
  .v6: 'v6',
  .v7: 'v7',
  .v8: 'v8',
};
const uppercaseDigitsSetting = 'Use uppercase letters in UUIDs';
const uuidColorSetting = 'Computed colors for each UUID';
