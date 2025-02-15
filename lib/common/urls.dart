// Copyright 2014-2025 Tecdrop (https://www.tecdrop.com/)
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file.

/// Urls used in the app.
library;

const String rateApp = 'https://play.google.com/store/apps/details?id=com.tecdrop.tapguid';
const String help = 'https://www.tecdrop.com/tapguid/';
const String proApps = 'https://www.tecdrop.com/apps/pro/';

String webSearch(String query) => 'https://www.google.com/search?q="${Uri.encodeComponent(query)}"';
