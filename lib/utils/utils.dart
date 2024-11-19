// Copyright 2022 Aurelitec. All rights reserved.
// Use of this source code is governed by a user license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher_string.dart';

/// Shows a default [SnackBar] with the specified text, after hiding any previous snackbars.
void showSnackBar(BuildContext context, String text) {
  final SnackBar snackBar = SnackBar(content: Text(text));
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
}

/// Launches the specified [URL] in the mobile platform.
///
/// Shows an error [SnackBar] if there is no support for launching the URL.
Future<void> launchUrlWrapper(BuildContext context, String url) async {
  // TODO: Reimplement using launchUrl
  if (!await launchUrlString(url)) showSnackBar(context, 'Failed to open $url');
}

/// Performs a web search for the specified text.
///
/// This works only on Android platforms.
Future<void> webSearch(String query) async {
  // TODO: Implement the webSearch function in a cross-platform way.

  // if (Platform.isAndroid) {
  //   AndroidIntent intent = AndroidIntent(
  //     action: 'android.intent.action.WEB_SEARCH',
  //     arguments: {'query': query},
  //   );
  //   await intent.launch();
  // }
}

/// Performs a web search for the specified text.
///
/// This works only on Android platforms.
Future<void> shareText(String text, String title) async {
  // TODO: Implement the shareText function in a cross-platform way.

  // if (Platform.isAndroid) {
  //   AndroidIntent intent = AndroidIntent(
  //     action: 'android.intent.action.SEND',
  //     type: 'text/plain',
  //     arguments: <String, String>{'android.intent.extra.TEXT': text},
  //   );
  //   await intent.launchChooser(title);
  // }
}
