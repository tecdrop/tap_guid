// Copyright 2020-2025 Tecdrop SRL. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file or at https://www.tecdrop.com/tapguid/license/.

import 'package:flutter/material.dart';

import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

import '../common/preferences.dart' as prefs;
import '../common/strings.dart' as strings;
import '../common/types.dart';
import '../common/urls.dart' as urls;
import '../utils/color_utils.dart' as color_utils;
// import '../utils/internal_utils.dart';
import '../utils/utils.dart' as utils;
import '../utils/uuid_utils.dart';
import '../widgets/internal/app_drawer.dart';
import '../widgets/internal/home_app_bar.dart';
import '../widgets/uniform_wrappable_text.dart';
import 'settings_screen.dart';

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

  /// The color of the current UUID.
  late Color _uuidColor;

  /// The cached text style for the UUID display.
  late TextStyle _uuidTextStyle;

  /// The cached character width for the UUID display.
  late double _uuidCharacterWidth;

  /// The tab controller for the UUID format tabs.
  late TabController _tabController;

  /// Generates a new UUID and updates the display.
  void _genNewUuid() {
    _uuidValue = switch (prefs.uuidVersion.value) {
      UuidVersion.v1 => _uuid.v1(),
      UuidVersion.v4 => _uuid.v4(),
      UuidVersion.v6 => _uuid.v6(),
      UuidVersion.v7 => _uuid.v7(),
      UuidVersion.v8 => _uuid.v8(),
    };

    // TODO: Make sure the following line is commented out in production
    // _uuidValue = getMockUuid(1);

    _uuidColor = getUuidColor(_uuidValue);
    _updateUuidFormat();
  }

  /// Updates the UUID format display based on the current tab.
  void _updateUuidFormat() {
    _uuidFormatValue = formatUuid(
      _uuidValue,
      format: UuidFormat.values[_tabController.index],
      uppercase: prefs.uppercaseDigits.value,
    );
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: strings.uuidFormatTabs.length);
    _tabController.addListener(() {
      // Update the UUID format display when the tab changes
      setState(() => _updateUuidFormat());
    });

    // Load app preferences
    () async {
      await prefs.load();
      setState(() {});
    }();

    // Generate a new UUID when the screen is first displayed
    _genNewUuid();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Cache the text style and character width for the UUID display
    final bool isLargeScreen = MediaQuery.sizeOf(context).width > 600.0;
    _uuidTextStyle =
        isLargeScreen
            ? Theme.of(context).textTheme.displaySmall!
            : Theme.of(context).textTheme.headlineLarge!;
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

  /// Navigate to the settings screen and update the UUID format if necessary after returning.
  Future<void> _gotoSettingsScreen() async {
    final UuidVersion oldVersion = prefs.uuidVersion.value;
    await utils.navigateTo(context: context, screen: const SettingsScreen());
    setState(
      // Generate a new UUID if the UUID version has changed, or just update the format
      () => prefs.uuidVersion.value != oldVersion ? _genNewUuid() : _updateUuidFormat(),
    );
  }

  /// Perform the actions of the app drawer.
  void _onDrawerItemTap(AppDrawerItems item) {
    // First close the drawer
    Navigator.pop(context);

    switch (item) {
      // Open the urls of the Pro apps
      case AppDrawerItems.pbwp:
        utils.launchUrlExternal(context, urls.pbwp);
        break;
      case AppDrawerItems.rcwp:
        utils.launchUrlExternal(context, urls.rcwp);
        break;

      case AppDrawerItems.guidGenerator:
        // Do nothing - simply stay on the Home screen as we are already there
        break;

      // Open the app settings screen and update the display when the user returns
      case AppDrawerItems.settings:
        _gotoSettingsScreen();
        break;

      // Open the app home page in the default browser
      case AppDrawerItems.help:
        utils.launchUrlExternal(context, urls.help);
        break;

      // Open the open source repository in the default browser
      case AppDrawerItems.openSource:
        utils.launchUrlExternal(context, urls.openSource);
        break;

      // Open the Google Play app page to allow the user to rate the app.
      case AppDrawerItems.rateApp:
        utils.launchUrlExternal(context, urls.rateApp);
        break;
    }
  }

  /// Perform the actions of the app bar.
  void _onAppBarAction(HomeAppBarActions action) {
    switch (action) {
      // Copy the UUID value in the current format to the clipboard
      case HomeAppBarActions.copy:
        // Do not display the UUID value in the snackbar, as it may be too long for a snackbar
        utils.copyToClipboard(context, _uuidFormatValue, valueToDisplay: strings.uuid);
        break;

      // Share the UUID value in the current format via the platform's share dialog
      case HomeAppBarActions.share:
        Share.share(_uuidFormatValue, subject: strings.shareSubject);
        break;

      // Copy the color of the UUID to the clipboard
      case HomeAppBarActions.copyColor:
        utils.copyToClipboard(context, color_utils.toHexString(_uuidColor));
        break;

      // Perform a web search for the Uuid value in the current format.
      case HomeAppBarActions.uniquenessSearch:
        utils.launchUrlExternal(context, urls.webSearch(_uuidFormatValue));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = MediaQuery.sizeOf(context).width > 600.0;
    final EdgeInsets padding = EdgeInsets.symmetric(horizontal: isLargeScreen ? 64.0 : 16.0);

    final Color backColor =
        prefs.uuidColor.value ? _uuidColor : Theme.of(context).colorScheme.tertiary;
    final Color foreColor = color_utils.contrastColor(backColor);

    // The UUID display with uniform width characters
    final Widget uuidText = UniformWrappableText(
      _uuidFormatValue,
      style: _uuidTextStyle.copyWith(color: foreColor),
      characterWidth: _uuidCharacterWidth,
    );

    return Scaffold(
      // The app bar with tabs and actions
      appBar: HomeAppBar(tabController: _tabController, onAction: _onAppBarAction),

      // The app drawer with screen navigation and app related urls
      drawer: AppDrawer(headerColor: backColor, onItemTap: _onDrawerItemTap),

      body:
          prefs.uuidColor.value
              // Use an animated container to animate background color changes if UUID color is enabled
              ? AnimatedContainer(
                // Use an almost unnoticeable duration for a subtle color change effect
                duration: const Duration(milliseconds: 100),
                color: backColor,
                width: double.infinity,
                height: double.infinity,
                padding: padding,
                alignment: Alignment.center,
                child: uuidText,
              )
              : Container(
                color: backColor,
                padding: padding,
                alignment: Alignment.center,
                child: uuidText,
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
