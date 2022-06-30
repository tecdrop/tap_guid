// Copyright 2022 Aurelitec. All rights reserved.
// Use of this source code is governed by a user license that can be
// found in the LICENSE file.

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../common/ui_strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Uuid _uuid = const Uuid();
  late String _uuidValue;

  void _genNewUuid() {
    _uuidValue = _uuid.v4();
  }

  @override
  void initState() {
    super.initState();
    _genNewUuid();
  }

  void _onFabPressed() {
    setState(() {
      _genNewUuid();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: _AppBar(
          onAction: (_AppBarOverflowActions action) {},
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              _uuidValue,
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
      ),
    );
  }
}

/// The actions available in the app bar.
enum _AppBarOverflowActions { copy, share }

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({required this.onAction});

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
      bottom: const TabBar(
        isScrollable: true,
        tabs: [
          Tab(text: 'Standard'),
          Tab(text: 'Digits'),
          Tab(text: 'Braces'),
          Tab(text: 'Parentheses'),
          Tab(text: 'URN'),
          Tab(text: 'Base64'),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}
