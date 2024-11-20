// Copyright 2014-2024 Tecdrop (https://www.tecdrop.com/)
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import 'package:uuid/uuid.dart';

import '../common/app_urls.dart';
import '../common/strings.dart' as strings;
import '../common/types.dart';
import '../utils/color_utils.dart' as color_utils;
import '../utils/utils.dart' as utils;
import '../utils/uuid_utils.dart';
import '../widgets/uniform_wrappable_text.dart';

/// The home screen of the app.
///
/// Generates and displays a UUID in various formats and allows the user to copy, share, and search
/// for the UUID online.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  /// The UUID generator.
  final Uuid _uuid = const Uuid();

  /// The value of the current UUID.
  late String _uuidValue;

  /// The value of the current UUID in the selected format.
  late String _uuidFormatValue;

  /// The cached text style for the UUID display.
  late TextStyle _uuidTextStyle;

  /// The cached character width for the UUID display.
  late double _uuidCharacterWidth;

  /// The tab controller for the UUID format tabs.
  late TabController _tabController;

  /// Generates a new UUID and updates the display.
  void _genNewUuid() {
    _uuidValue = _uuid.v4();
    _updateUuidFormat();
  }

  /// Updates the UUID format display based on the current tab.
  void _updateUuidFormat() {
    _uuidFormatValue = formatUuid(_uuidValue, UuidFormat.values[_tabController.index]);
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: strings.uuidFormatTabs.length);
    _tabController.addListener(() {
      // Update the UUID format display when the tab changes
      setState(() => _updateUuidFormat());
    });

    // Generate a new UUID when the screen is first displayed
    _genNewUuid();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Cache the text style and character width for the UUID display
    _uuidTextStyle = Theme.of(context).textTheme.headlineLarge!;
    _uuidCharacterWidth = UniformWrappableText.getWidestCharacterWidth(_uuidTextStyle);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// Generate a new UUID and update the display when the FAB is pressed.
  void _onFabPressed() {
    setState(() => _genNewUuid());
  }

  /// Perform the actions of the app bar.
  void _onAppBarAction(_AppBarActions action) {
    switch (action) {
      // Copy the UUID value in the current format to the clipboard
      case _AppBarActions.copy:
        utils.copyToClipboard(context, _uuidFormatValue);
        break;

      // Share the UUID value in the current format via the platform's share dialog
      case _AppBarActions.share:
        Share.share(_uuidFormatValue, subject: strings.shareSubject);
        break;

      // Perform a web search for the Uuid value in the current format.
      case _AppBarActions.uniquenessSearch:
        utils.webSearch('"$_uuidFormatValue"');
        break;

      // Open the Google Play app page to allow the user to rate the app.
      case _AppBarActions.rate:
        utils.launchUrlExternal(context, AppUrls.rateActionUrl);
        break;

      case _AppBarActions.settings:
        // TODO: Handle this case.
        break;

      // Open the app home page in the default browser.
      case _AppBarActions.help:
        utils.launchUrlExternal(context, AppUrls.helpActionUrl);
        break;

      case _AppBarActions.goPro:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color backColor = getUuidColor(_uuidValue);
    final Color foreColor = color_utils.contrastColor(backColor);

    return Scaffold(
      // The app bar with tabs and actions
      appBar: _AppBar(
        tabController: _tabController,
        onAction: _onAppBarAction,
      ),

      // Use an animated container to animate the background color change
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: backColor,
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),

        // Display the UUID in the selected format with uniform width characters
        child: UniformWrappableText(
          _uuidFormatValue,
          style: _uuidTextStyle.copyWith(color: foreColor),
          characterWidth: _uuidCharacterWidth,
        ),
      ),

      // The refresh FAB that generates a new UUID
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: foreColor,
        foregroundColor: color_utils.contrastColor(foreColor),
        tooltip: strings.newUuidTooltip,
        onPressed: _onFabPressed,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

/// The actions available in the app bar.
enum _AppBarActions { copy, share, uniquenessSearch, settings, rate, help, goPro }

/// The app bar for the home screen.
class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({
    super.key, // ignore: unused_element
    this.tabController,
    required this.onAction,
  });

  /// The tab controller for the UUID format tabs.
  final TabController? tabController;

  /// The callback that is called when an app bar action is pressed.
  final Function(_AppBarActions action) onAction;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(strings.homeScreenTitle),
      actions: <Widget>[
        // The copy action button
        IconButton(
          icon: const Icon(Icons.content_copy_rounded),
          tooltip: strings.copyTooltip,
          onPressed: () => onAction(_AppBarActions.copy),
        ),
        // The Share action button
        IconButton(
          icon: const Icon(Icons.share_rounded),
          tooltip: strings.shareTooltip,
          onPressed: () => onAction(_AppBarActions.share),
        ),

        PopupMenuButton<_AppBarActions>(
          onSelected: onAction,
          itemBuilder: (BuildContext context) => <PopupMenuEntry<_AppBarActions>>[
            // The Uniqueness Search action button
            const PopupMenuItem<_AppBarActions>(
              value: _AppBarActions.uniquenessSearch,
              child: Text(strings.uniquenessSearchAction),
            ),

            const PopupMenuDivider(),

            // The Settings action button
            const PopupMenuItem<_AppBarActions>(
              value: _AppBarActions.settings,
              child: Text(strings.settingsAction),
            ),

            // The Rate action button
            const PopupMenuItem<_AppBarActions>(
              value: _AppBarActions.rate,
              child: Text(strings.rateAction),
            ),

            // The Help action button
            const PopupMenuItem<_AppBarActions>(
              value: _AppBarActions.help,
              child: Text(strings.helpAction),
            ),

            const PopupMenuDivider(),

            // The Go Pro action button
            const PopupMenuItem<_AppBarActions>(
              value: _AppBarActions.goPro,
              child: Text(strings.goProAction),
            ),
          ],
        ),
      ],
      // The UUID format tabs
      bottom: TabBar(
        controller: tabController,
        isScrollable: true,
        tabs: strings.uuidFormatTabs.keys
            .map((format) => Tab(text: strings.uuidFormatTabs[format]))
            .toList(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}
