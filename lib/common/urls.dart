// Copyright 2020-2025 Tecdrop SRL. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file or at https://www.tecdrop.com/tapguid/license/.

/// Urls used in the app.
library;

const String rateApp = 'https://play.google.com/store/apps/details?id=com.tecdrop.tapguid';
const String help = 'https://www.tecdrop.com/tapguid/';
const String proApps = 'https://www.tecdrop.com/apps/pro/';

String webSearch(String query) => 'https://www.google.com/search?q="${Uri.encodeComponent(query)}"';
