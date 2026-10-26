// Copyright 2020-2026 Tecdrop SRL. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file or at https://www.tecdrop.com/tapguid/license/.

/// Urls used in the app.
library;

const pbwp = 'https://play.google.com/store/apps/details?id=com.tecdrop.pitchblackwallpaperpro';
const rcwp = 'https://play.google.com/store/apps/details?id=com.tecdrop.rgbcolorwallpaperpro';

const help = 'https://www.tecdrop.com/tapguid/';
const openSource = 'https://github.com/tecdrop/tap_guid';
const rateApp = 'https://play.google.com/store/apps/details?id=com.tecdrop.tapguid';

String webSearch(String query) => 'https://www.google.com/search?q="${Uri.encodeComponent(query)}"';
