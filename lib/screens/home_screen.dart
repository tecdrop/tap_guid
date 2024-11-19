// Copyright 2022 Aurelitec. All rights reserved.
// Use of this source code is governed by a user license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:uuid/uuid.dart';

import '../common/app_urls.dart';
import '../common/ui_strings.dart';
import '../utils/utils.dart';
import '../utils/uuid_format.dart';
import '../widgets/home_app_bar.dart';

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

  void _genNewUuid() {
    _uuidValue = _uuid.v4();
    _updateUuidFormat();
  }

  void _updateUuidFormat() {
    _uuidFormatValue = formatUuid(_uuidValue, _tabController.index);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: UIStrings.home_formatTabs.length);
    _tabController.addListener(() {
      setState(() {
        _updateUuidFormat();
      });
    });
    _genNewUuid();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onFabPressed() {
    setState(() {
      _genNewUuid();
    });
  }

  /// Perform the actions of the app bar.
  void _onAppBarAction(HomeAppBarActions action) {
    switch (action) {
      case HomeAppBarActions.copy:
        Clipboard.setData(ClipboardData(text: _uuidFormatValue))
            .then((value) => showSnackBar(context, UIStrings.home_copiedSnackBar));
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
      // Open the app home page in the default browser.
      case HomeAppBarActions.help:
        launchUrlWrapper(context, AppUrls.helpActionUrl);
        break;
      case HomeAppBarActions.goPro:
      // TODO: Handle this case.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        tabController: _tabController,
        onAction: _onAppBarAction,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            _uuidFormatValue,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontFeatures: [const FontFeature.tabularFigures()],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: UIStrings.home_fabTooltip,
        onPressed: _onFabPressed,
        child: const Icon(Icons.shuffle),
      ),
    );
  }
}
