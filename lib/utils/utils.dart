// Copyright 2014-2024 Tecdrop (https://www.tecdrop.com/)
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:url_launcher/url_launcher.dart';

import '../common/strings.dart' as strings;

/// Shows a default [SnackBar] with the specified text, after hiding any previous snackbars.
void showSnackBar(BuildContext context, String text) {
  final SnackBar snackBar = SnackBar(content: Text(text));
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
}

/// Launches the specified [URL] in the mobile platform, using the default external application.
Future<void> launchUrlExternal(BuildContext context, String url) async {
  await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
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

/// Shows a [SnackBar] with the specified [text] across all registered [Scaffold]s.
void showSnackBarForAsync(ScaffoldMessengerState messengerState, String text) {
  final SnackBar snackBar = SnackBar(content: Text(text));
  messengerState
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
}

/// Stores the given text on the clipboard, and shows a [SnackBar] on success and on failure.
Future<void> copyToClipboard(BuildContext context, String value) async {
  ScaffoldMessengerState messengerState = ScaffoldMessenger.of(context);
  try {
    await Clipboard.setData(ClipboardData(text: value));
    showSnackBarForAsync(messengerState, strings.copiedSnack(value));
  } catch (error) {
    showSnackBarForAsync(messengerState, strings.copiedErrorSnack(value));
  }
}
