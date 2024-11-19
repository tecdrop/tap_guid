// Copyright 2014-2024 Tecdrop (https://www.tecdrop.com/)
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final Color backColor = getUuidColor(_uuidValue);
    final Color foreColor = color_utils.contrastColor(backColor);

    return Scaffold(
      backgroundColor: backColor,
      appBar: HomeAppBar(
        tabController: _tabController,
        onAction: _onAppBarAction,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: UniformWrappableText(
            _uuidFormatValue,
            // textAlign: TextAlign.center,
            // softWrap: false,
            // overflow: TextOverflow.fade,

            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: foreColor,
                  // fontFamily: 'monospace',
                  // fontFeatures: [const FontFeature.tabularFigures()],
                ),
            // style: GoogleFonts.robotoMono(
            //   // textStyle: Theme.of(context).textTheme.headlineMedium,
            //   color: foreColor,
            //   fontSize: 50.0,

            //   // letterSpacing: 10.0,

            //   // fontFeatures: [const FontFeature.tabularFigures()],
            // ),
          ),
        ),
      ),
      // body: Expanded(
      //   child: Text(
      //     _uuidFormatValue,
      //     // textAlign: TextAlign.center,
      //     // softWrap: false,
      //     // overflow: TextOverflow.fade,

      //     // style: Theme.of(context).textTheme.headlineMedium?.copyWith(
      //     //       color: foreColor,
      //     //       fontFamily: 'monospace',
      //     //       // fontFeatures: [const FontFeature.tabularFigures()],
      //     //     ),
      //     style: GoogleFonts.robotoMono(
      //       // textStyle: Theme.of(context).textTheme.headlineMedium,
      //       color: foreColor,
      //       fontSize: 50.0,

      //       // letterSpacing: 10.0,

      //       // fontFeatures: [const FontFeature.tabularFigures()],
      //     ),
      //   ),
      // ),
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: foreColor,
        foregroundColor: color_utils.contrastColor(foreColor),
        tooltip: strings.newUuidTooltip,
        onPressed: _onFabPressed,
        child: const Icon(Icons.shuffle),
      ),
    );
  }
}
