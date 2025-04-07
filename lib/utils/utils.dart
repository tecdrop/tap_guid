// Copyright 2020-2025 Tecdrop SRL. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file or at https://www.tecdrop.com/tapguid/license/.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:url_launcher/url_launcher.dart';

import '../common/strings.dart' as strings;

/// Navigates to the specified [screen] and returns the result.
Future<T?> navigateTo<T>({
  BuildContext? context,
  NavigatorState? navigator,
  required Widget screen,
  RouteSettings? settings,
}) async {
  assert(context != null || navigator != null, 'Either context or navigator must be specified');

  navigator ??= Navigator.of(context!);
  return await navigator.push(
    MaterialPageRoute<T>(settings: settings, builder: (context) => screen),
  );
}

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
