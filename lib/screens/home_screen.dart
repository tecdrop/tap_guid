// Copyright 2014-2024 Tecdrop (https://www.tecdrop.com/)
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:uuid/uuid.dart';

import '../common/app_urls.dart';
import '../common/strings.dart' as strings;
import '../common/types.dart';
import '../utils/color_utils.dart' as color_utils;
import '../utils/utils.dart';
import '../utils/uuid_utils.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/uniform_wrappable_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final Uuid _uuid = const Uuid();
  late String _uuidValue;
  late String _uuidFormatValue;

  late TabController _tabController;

  late final TextStyle _uuidTextStyle;
  late final double _uuidCharacterWidth;

  void _genNewUuid() {
    _uuidValue = _uuid.v4();
    _updateUuidFormat();
  }

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
  void _onAppBarAction(HomeAppBarActions action) {
    switch (action) {
      case HomeAppBarActions.copy:
        Clipboard.setData(ClipboardData(text: _uuidFormatValue))
            .then((value) => showSnackBar(context, strings.copiedSnackBar));
        break;
      case HomeAppBarActions.share:
        shareText(_uuidFormatValue, 'Share UUID');
        break;
      // Perform a web search for the Uuid value in the current format.
      case HomeAppBarActions.uniquenessSearch:
        webSearch('"$_uuidFormatValue"');
        break;
      // Open the Google Play app page to allow the user to rate the app.
      case HomeAppBarActions.rate:
        launchUrlWrapper(context, AppUrls.rateActionUrl);
        break;
      case HomeAppBarActions.settings:
        // TODO: Handle this case.
        break;
      // Open the app home page in the default browser.
      case HomeAppBarActions.help:
        launchUrlWrapper(context, AppUrls.helpActionUrl);
        break;
      case HomeAppBarActions.goPro:
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
      appBar: HomeAppBar(
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
