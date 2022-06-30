// Copyright 2022 Aurelitec. All rights reserved.
// Use of this source code is governed by a user license that can be
// found in the LICENSE file.

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../common/ui_strings.dart';
import '../utils/uuid_format.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final Uuid _uuid = const Uuid();
  late String _uuidValue;

  late TabController _tabController;

  void _genNewUuid() {
    _uuidValue = _uuid.v4();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: UIStrings.home_formatTabs.length);
    _tabController.addListener(() {
      setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(
        tabController: _tabController,
        onAction: (_AppBarOverflowActions action) {},
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            formatUuid(_uuidValue, _tabController.index),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5!.copyWith(
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

/// The actions available in the app bar.
enum _AppBarOverflowActions { copy, share }

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({
    this.tabController,
    required this.onAction,
  });

  final TabController? tabController;

  /// The callback that is called when an app bar action is pressed.
  final Function(_AppBarOverflowActions action) onAction;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(UIStrings.home_screenTitle),
      actions: [
        IconButton(
          icon: const Icon(Icons.content_copy_rounded),
          tooltip: UIStrings.home_copyTooltip,
          onPressed: () => onAction(_AppBarOverflowActions.copy),
        ),
        PopupMenuButton<_AppBarOverflowActions>(
          onSelected: onAction,
          itemBuilder: (BuildContext context) => <PopupMenuEntry<_AppBarOverflowActions>>[
            const PopupMenuItem<_AppBarOverflowActions>(
              value: _AppBarOverflowActions.share,
              child: Text(UIStrings.home_shareAction),
            ),
          ],
        ),
      ],
      bottom: TabBar(
        controller: tabController,
        isScrollable: true,
        tabs: UIStrings.home_formatTabs.keys
            .map((format) => Tab(text: UIStrings.home_formatTabs[format]))
            .toList(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}
